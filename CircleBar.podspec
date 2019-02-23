#
# Be sure to run `pod lib lint CircleBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CircleBar'
  s.version          = '0.8.1'
  s.summary          = 'A fun, easy-to-use tab bar navigation controller for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/softhausHQ/CircleBar'
  s.screenshots     = 'https://user-images.githubusercontent.com/7403338/53284076-884de700-3757-11e9-9185-33a67e7b3ba0.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'softhaus' => 'adi@softhaus.org' }
  s.source           = { :git => 'https://github.com/softhausHQ/CircleBar.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/softhausHQ'

  s.ios.deployment_target = '12.0'
  s.swift_version = '4.2'
  s.source_files = 'CircleBar/Classes/*'
  
  # s.resource_bundles = {
  #   'CircleBar' => ['CircleBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
