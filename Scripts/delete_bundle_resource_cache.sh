#!/bin/sh

# Get the changes in git diff and delete module bundle resources correspond to the xib module bundle.
# This will refresh any changes made in xib and images.
# When specified with --delete-all, will all delete module resource bundles.
# WARNING: THIS SCRIPT SHOULD BE ADDED In Pre-actions in the Build section inside SandboxApp or Traveloka scheme

delete_all=$1

if [[ $delete_all == "--delete-all" ]]; then
    echo "deleting all module bundle"

   for bundle in $(find $PODS_CONFIGURATION_BUILD_DIR -name "*Resources.bundle"); do
      rm -rf $bundle
      echo "deleting $bundle"
   done
fi

# Get module resoure bundle that need to be deleted
git add ../ # Add any untracked files
for file in $((git diff --staged --name-only && git diff --name-only) | grep ".xib\|.xcassets"); do
  module_path=${file##*/Modules/}
  module_name=$(echo $module_path | cut -d "/" -f1)

  echo "path: $module_path"

  if ! [[ " ${module_names[*]} " == *" ${module_name} "* ]]; then
    echo "adding: $module_name"
    module_names+=($module_name)
  fi

  echo "module_nameess: $module_names"
done

# Delete the bundle in DerivedData
for module_name in ${module_names[@]}; do
  rm -rf "$PODS_CONFIGURATION_BUILD_DIR/$module_name/${module_name}Resources.bundle"
  echo "deleting $PODS_CONFIGURATION_BUILD_DIR/$module_name/${module_name}Resources.bundle"
done
