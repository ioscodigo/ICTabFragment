Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.name = 'ICTabFragment'
  s.summary = 'Tab menu with page view controller'
  s.requires_arc = true
  s.version = '1.0.0'
  s.license = { :type => "MIT", :file => 'LICENSE' }
  s.author = { 'Digital Khrisna' => 'digital.khrisna@gmail.com' }
  s.homepage = 'https://github.com/ioscodigo/ICTabFragment'
  s.source = { :git => 'https://github.com/ioscodigo/ICTabFragment.git', :tag => '1.0.0'}
  s.framework = "UIKit"
  s.source_files = "ICTabFragment/**/*.{swift}"
end