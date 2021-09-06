#!/bin/sh

set -x

# Buck Package.
# This step usually contains run script in the Build Phase 'Run Script' such as:
# * Stripping frameworks
# * Build phase run scripts
# * plutil (converts .strings to binary)
#
# Arguments:
# - Build scheme type [Traveloka Staging | Traveloka]
# - App Path [xxx/xxx/xxx.app] The app path
# Usage: ./run_build_phase.sh [Traveloka Staging | Traveloka] [./your/app/path.app/]

BUILD_SCHEME=`echo $1 | sed 's/_//g' | sed 's/ //g'`
APP_PATH="$2"
DSYM_ZIP_PATH="$3"
ROOT_PATH="`pwd | sed 's/\/Traveloka.*//g'`/Traveloka"
TARGET_DEVICE_FAMILY="1" # Target device family 1: iphone, ipod. 2: ipad, 1,2: universal

if [[ -z $BUILD_SCHEME || -z $APP_PATH ]]; then
  echo "\033[0;31m Error Usage: ./run_build_phase.sh [Traveloka Staging | Traveloka] [./your/app/path.app/]\033[0m"
  exit 1
fi

cd $ROOT_PATH

# Set Build Info for Developer Settings
if [[ $BUILD_SCHEME == "TravelokaStaging" ]]; then
  $ROOT_PATH/Scripts/BuildScripts/plist_build_info.sh "$APP_PATH/Info.plist"
fi

# Strip framework for release config
$ROOT_PATH/Scripts/BuildScripts/strip_frameworks.sh "arm64 arm64e" "$APP_PATH/Frameworks"

# Generate debug symbols: This step must be ran after stripping framework.
$ROOT_PATH/Scripts//generate_debug_symbols.sh "$BUILD_SCHEME" "$APP_PATH/../../Symbols" "$APP_PATH" "$DSYM_ZIP_PATH"

# Add UIDeviceFamily
/usr/libexec/PlistBuddy -c "Add :UIDeviceFamily array" "$APP_PATH/Info.plist" 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :UIDeviceFamily:0 integer '${TARGET_DEVICE_FAMILY}'" "$APP_PATH/Info.plist" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :UIDeviceFamily:0 '${TARGET_DEVICE_FAMILY}'" "$APP_PATH/Info.plist" 2>/dev/null

# Run Plutil for Localizable.strings and InfoPlist.strings
for file in $(find -E $APP_PATH -type f -regex ".*.app\/[a-zA-Z][a-zA-Z].lproj\/(Localizable|InfoPlist).strings"); do
  plutil -convert binary1 $file
done

cd -
