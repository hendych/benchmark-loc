#!/bin/sh

# Take first args as info plist path
# Usage ./plist_build_info.sh <info_plist_path>
info_plist=$1
git_version=$(git log -1 --format="%h")
git_branch=$(git symbolic-ref --short -q HEAD)
git_tag=$(git describe --tags --exact-match 2>/dev/null)

build_time=$(date)
git_branch_or_tag="${git_branch:-${git_tag}}"

/usr/libexec/PlistBuddy -c "Add :BranchName string '${git_branch_or_tag}-${git_version}'" "${info_plist}" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :BranchName '${git_branch_or_tag}-${git_version}'" "${info_plist}" 2>/dev/null
/usr/libexec/PlistBuddy -c "Add :BuildTime string '${build_time}'" "${info_plist}" 2>/dev/null || /usr/libexec/PlistBuddy -c "Set :BuildTime '${build_time}'" "${info_plist}" 2>/dev/null
