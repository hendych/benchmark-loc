#!/bin/bash

set -x

VALID_ARCHS=$1
FRAMEWORK_PATH=$2

# Run rsync, filters all unused headers and files inside framework, taken from pods copy embedded frameworks
echo "Run rsync in frameworks"

mkdir $FRAMEWORK_PATH/tmp

for file in $(find -E $FRAMEWORK_PATH -type d -perm +111 -regex ".*.framework$"); do
  FILENAME=${file##*/}

  rsync --delete -av --filter "P .*.??????" --links --filter "- CVS/" \
   --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers" \
   --filter "- PrivateHeaders" --filter "- Modules" \
   $file $FRAMEWORK_PATH/tmp

   rm -rf $file
   mv $FRAMEWORK_PATH/tmp/$FILENAME $FRAMEWORK_PATH

   # Clean bcsymbolmap
   for bcsymbol in $(find $file -type f -name "*.bcsymbolmap"); do
     rm -rf $bcsymbol
   done
done

rm -rf $FRAMEWORK_PATH/tmp

echo "Stripping frameworks for arch $VALID_ARCHS in $FRAMEWORK_PATH"

for file in $(find $FRAMEWORK_PATH -type f -perm +111); do
  # Skip non framework dirs
  if [[ $file != *".framework"* ]]; then
    continue
  fi

  # Skip non-dynamic libraries
  if [[ "$(file "$file")" != *"dynamically linked shared library"* ]]; then
    continue
  fi

  echo "Stripping $file"

  # Get architectures for current file
  archs="$(lipo -info "${file}" | rev | cut -d ':' -f1 | rev)"

  if ! [[ $archs == *"arm"* ]]; then
    echo "Skipping $file as it doesn't have arch for ios devices"
    continue
  fi

  # Strip FAT framework from non arm archs
  stripped=""
  for arch in $archs; do
    if ! [[ "${VALID_ARCHS}" == *"$arch"* ]]; then
      # Strip non-valid architectures in-place
      lipo -remove "$arch" -output "$file" "$file" || exit 1
      stripped="$stripped $arch"
    fi
  done
  if [[ "$stripped" != "" ]]; then
    echo "Stripped $file of architectures:$stripped"
  fi

  # Strip dynamic framework from bitcode
  xcrun bitcode_strip -r $file -o $file

done
