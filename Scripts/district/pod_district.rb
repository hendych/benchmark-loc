# Wrapper to include react-native dependencies.
#
# Options:
# :react_native_path => define react-native directory
# :splits_enabled => enable/disable react-native-splits
def use_district(options={})
  # 3rd party dependencies
  bugsnag_react_native_tag = 'v2.23.10'
  code_push_tag = 'splits/v6.1.0-7'
  react_native_svg_tag = 'v9.3.3'
  react_native_maps_tag = 'v0.25.0'
  react_native_netinfo_tag = 'v4.1.3'
  react_native_webview_tag = 'v7.5.2'
  react_native_geolocation_tag = 'v1.4.2'
  react_native_splits_tag = 'v2.3.11'
  react_native_viewpager_tag = 'v3.3.0'
  react_native_gesture_handler_tag = '1.6.0'
  react_native_reanimated_tag = '1.7.0'
  react_native_screens_tag = '2.16.1'

  # set options
  react_native_path = options[:react_native_path] ||= "../../react-native"
  splits_enabled = options[:splits_enabled] != nil ? options[:splits_enabled] : true

  pod 'FBLazyVector', :path => "#{react_native_path}/Libraries/FBLazyVector", :modular_headers => false
  pod 'FBReactNativeSpec', :path => "#{react_native_path}/Libraries/FBReactNativeSpec", :modular_headers => false
  pod 'RCTRequired', :path => "#{react_native_path}/Libraries/RCTRequired", :modular_headers => false
  pod 'RCTTypeSafety', :path => "#{react_native_path}/Libraries/TypeSafety", :modular_headers => false
  pod 'React', :path => "#{react_native_path}/", :modular_headers => false
  pod 'React-Core', :path => "#{react_native_path}/", :modular_headers => false
  pod 'React-CoreModules', :path => "#{react_native_path}/React/CoreModules", :modular_headers => false
  pod 'React-Core/DevSupport', :path => "#{react_native_path}/", :modular_headers => false
  pod 'React-RCTActionSheet', :path => "#{react_native_path}/Libraries/ActionSheetIOS", :modular_headers => false
  pod 'React-RCTAnimation', :path => "#{react_native_path}/Libraries/NativeAnimation", :modular_headers => false
  pod 'React-RCTBlob', :path => "#{react_native_path}/Libraries/Blob", :modular_headers => false
  pod 'React-RCTImage', :path => "#{react_native_path}/Libraries/Image", :modular_headers => false
  pod 'React-RCTLinking', :path => "#{react_native_path}/Libraries/LinkingIOS", :modular_headers => false
  pod 'React-RCTNetwork', :path => "#{react_native_path}/Libraries/Network", :modular_headers => false
  pod 'React-RCTSettings', :path => "#{react_native_path}/Libraries/Settings", :modular_headers => false
  pod 'React-RCTText', :path => "#{react_native_path}/Libraries/Text", :modular_headers => false
  pod 'React-RCTVibration', :path => "#{react_native_path}/Libraries/Vibration", :modular_headers => false
  pod 'React-Core/RCTWebSocket', :path => "#{react_native_path}/", :modular_headers => false

  pod 'React-cxxreact', :path => "#{react_native_path}/ReactCommon/cxxreact", :modular_headers => false
  pod 'React-jsi', :path => "#{react_native_path}/ReactCommon/jsi", :modular_headers => false
  pod 'React-jsiexecutor', :path => "#{react_native_path}/ReactCommon/jsiexecutor", :modular_headers => false
  pod 'React-jsinspector', :path => "#{react_native_path}/ReactCommon/jsinspector", :modular_headers => false
  pod 'ReactCommon/jscallinvoker', :path => "#{react_native_path}/ReactCommon", :modular_headers => false
  # pod 'ReactCommon/turbomodule/core', :path => "#{react_native_path}/ReactCommon", :modular_headers => false
  pod 'Yoga', :path => "#{react_native_path}/ReactCommon/yoga", :modular_headers => false

  pod 'DoubleConversion', :podspec => "#{react_native_path}/third-party-podspecs/DoubleConversion.podspec", :modular_headers => false
  pod 'glog', :podspec => "#{react_native_path}/third-party-podspecs/glog.podspec", :modular_headers => false
  pod 'Folly', :podspec => "#{react_native_path}/third-party-podspecs/Folly.podspec", :modular_headers => false

  pod 'react-native-fast-image', :git => "https://github.com/traveloka/react-native-fast-image.git", branch: 'master', commit: 'cd68721e6ba450670db40867990c781814b5766c', :modular_headers => false
  pod 'CodePush', :git => "git@github.com:traveloka/react-native-code-push.git", :tag => code_push_tag
  pod 'RNSVG', :git => "https://github.com/react-native-community/react-native-svg", :tag => react_native_svg_tag, :modular_headers => false
  pod 'BugsnagReactNative', :git => "https://github.com/bugsnag/bugsnag-react-native.git", :tag => bugsnag_react_native_tag
  pod 'react-native-maps', :git => "https://github.com/react-native-community/react-native-maps.git", :tag => react_native_maps_tag, :modular_headers => false

  pod 'react-native-netinfo', :git => "https://github.com/react-native-community/react-native-netinfo.git", :tag => react_native_netinfo_tag, :modular_headers => false
  pod 'react-native-webview', :git => "https://github.com/react-native-community/react-native-webview.git", :tag => react_native_webview_tag
  pod 'react-native-geolocation', :git => "https://github.com/react-native-community/react-native-geolocation.git", :tag => react_native_geolocation_tag, :modular_headers => false
  pod 'react-native-viewpager', :git => "https://github.com/react-native-community/react-native-viewpager.git", :tag => react_native_viewpager_tag, :modular_headers => false
  pod 'RNGestureHandler', :git => "https://github.com/software-mansion/react-native-gesture-handler.git", :tag => react_native_gesture_handler_tag, :modular_headers => false
  pod 'RNReanimated', :git => "https://github.com/software-mansion/react-native-reanimated.git", :tag => react_native_reanimated_tag, :modular_headers => false
  pod 'RNScreens', :git => 'git@github.com:software-mansion/react-native-screens.git', :tag => react_native_screens_tag

  if splits_enabled
    pod 'RNReactNativeSplits', :git => "git@github.com:traveloka/react-native-splits.git", :tag => react_native_splits_tag
  end
end

# use_district wrapper. react-native-splits disabled.
def use_osmosis(options={})
  # override options; disable react-native-splits on osmosis consumer
  options[:splits_enabled] = false

  use_district(options)
end
