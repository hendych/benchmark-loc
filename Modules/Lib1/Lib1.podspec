#
# Be sure to run `pod lib lint Lib1.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Lib1'
  s.version          = '0.1.0'
  s.summary          = 'Lib1 is module level xx.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Hendy Christianto/Lib1'
  s.author           = { 'Hendy Christianto' => 'hendy.christianto@traveloka.com' }
  s.source           = { :git => 'https://github.com/Hendy Christianto/Lib1.git', :tag => s.version.to_s }
  s.prefix_header_file = false
  s.ios.deployment_target = '12.0'

  s.source_files = 'Lib1/**/*.{h,m,swift}'

  s.resource_bundles = {
    'Lib1Resources' => ['Lib1/**/*.xib',
                               'Lib1Resources/**/*.xib',
                               'Lib1Resources/Images.xcassets']
  }

  # Test Spec
  s.test_spec 'Lib1Tests' do |test_spec|
    test_spec.source_files      = 'Tests/**/*.{m,swift}'

  end

  s.dependency 'SharedLib1'
end
