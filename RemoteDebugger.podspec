#
# Be sure to run `pod lib lint RemoteDebugger.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'RemoteDebugger'
  s.version          = '0.1.0'
  s.summary          = 'RemoteDebugger - View your logs in runtime.'
  s.description      = <<-DESC
RemoteDebugger is a new tool for view logs in runtime.
This tool give you the option to add logs with different levels, tags and more. 
                       DESC
  s.homepage         = 'https://github.com/yogevbar/RemoteDebugger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yogev Barber' => 'yogevbarber@gmail.com' }
  s.source           = { :git => 'https://github.com/yogevbar/RemoteDebuggerSDK.git', :tag => s.version.to_s }
  s.swift_version    = '5'

  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = 'RemoteDebugger.framework'  
end
