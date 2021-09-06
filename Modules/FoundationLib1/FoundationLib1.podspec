#
# Be sure to run `pod lib lint FoundationLib1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FoundationLib1'
  s.version          = '0.1.0'
  s.summary          = 'FoundationLib1 is module level xx.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Hendy Christianto/FoundationLib1'
  s.author           = { 'Hendy Christianto' => 'hendy.christianto@traveloka.com' }
  s.source           = { :git => 'https://github.com/Hendy Christianto/FoundationLib1.git', :tag => s.version.to_s }
  s.prefix_header_file = false
  s.ios.deployment_target = '12.0'

  s.source_files = 'FoundationLib1/**/*.{h,m,swift}'

  s.resource_bundles = {
    'FoundationLib1Resources' => ['FoundationLib1/**/*.xib',
                               'FoundationLib1Resources/**/*.xib',
                               'FoundationLib1Resources/Images.xcassets']
  }

  # Test Spec
  s.test_spec 'FoundationLib1Tests' do |test_spec|
    test_spec.source_files      = 'Tests/**/*.{m,swift}'

  end

  s.dependency 'AFNetworking', '~> 4.0'
  s.dependency 'SDWebImage', '~> 5.0'
  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/RemoteConfig'
  s.dependency 'Firebase/Crashlytics'
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/Messaging'
  s.dependency 'FirebaseFirestoreSwift'
  s.dependency 'Firebase/Storage'
  s.dependency 'Firebase/Performance'
  s.dependency 'ReactiveCocoa', '~> 10.1'
  s.dependency 'Realm', '~> 5.3.4'
  s.dependency 'SnapKit', '~> 5.0.0'
  s.dependency 'Masonry'
  s.dependency 'GoogleMaps'
  s.dependency 'GooglePlaces'
  s.dependency 'Google-Mobile-Ads-SDK'
  s.dependency 'GoogleSignIn'
  s.dependency 'VK-ios-sdk'
  s.dependency 'FacebookCore'
  s.dependency 'FacebookLogin'
  s.dependency 'FacebookShare'
  s.dependency 'TRON', '~> 5.0.0'
  s.dependency 'DTCollectionViewManager'
  s.dependency 'DTTableViewManager'
  s.dependency 'Ariadne'
  s.dependency 'LoadableViews'
  s.dependency 'Moya', '~> 14.0'
  s.dependency 'Starscream', '~> 4.0.0'
  s.dependency 'CryptoSwift', '~> 1.0'
  s.dependency 'R.swift.Library'
  s.dependency 'ObjectMapper'
  s.dependency 'RxBluetoothKit'
  s.dependency 'Eureka', '~> 5.3.2'
end
