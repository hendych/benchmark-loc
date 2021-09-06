#!/bin/sh

# Generate .symbols and /Symbols folder inside Release IPA.
# This symbols are debug symbols to symbolicate crash in apple.
# The step itself is actually optional. It will extract the symbols mainly from executables
# and dynamic framework executables.
#
# https://developer.apple.com/documentation/xcode/building_your_app_to_include_debugging_information

set -x

BUILD_SCHEME=`echo $1 | sed 's/_//g' | sed 's/ //g'`
SYMBOLS_OUTPUT_DIR="$2"
APP_DIR="$3"
DSYM_ZIP_PATH="$4"
ROOT_PATH="`pwd | sed 's/\/Traveloka.*//g'`/Traveloka"

if [[ -z $BUILD_SCHEME || -z $SYMBOLS_OUTPUT_DIR || -z $APP_DIR ]]; then
  echo "\033[0;31m Error usage: generate_debug_symbols.sh [Traveloka | Traveloka Staging] <symbols_output_dir> <unpacked_dot_app_dir>\033[0m"
  exit 1
fi

if [[ $BUILD_SCHEME == "TravelokaStaging" ]]; then
  echo "Skipping symbols generation for staging..."
  exit 0
fi

rm -rf $SYMBOLS_OUTPUT_DIR
mkdir $SYMBOLS_OUTPUT_DIR

FRAMEWORKS_PATH=$APP_DIR/Frameworks
APPEX_PATH=$APP_DIR/Plugins
EXECUTABLE_PATH=$APP_DIR/Traveloka

# Parse symbols from dynamic framework
for file in $(find $FRAMEWORKS_PATH -type f); do
  # Skip framework dirs
  if ! [[ $file == *"framework"* ]]; then
    continue
  fi
  if ! [[ "$(file "$file")" == *"dynamically linked shared library"* ]]; then
    continue
  fi

  xcrun symbols -noTextInSOD -noDaemon -arch all -symbolsPackageDir $SYMBOLS_OUTPUT_DIR $file
done

# Parse symbols from dSYMs for app and appex
unzip $DSYM_ZIP_PATH -d "dsyms"

for file in $(find -E "dsyms" -type f -regex ".*DWARF\/$BUILD_SCHEME.*"); do
  xcrun symbols -noTextInSOD -noDaemon -arch all -symbolsPackageDir $SYMBOLS_OUTPUT_DIR $file
done

rm -rf ./dsyms
