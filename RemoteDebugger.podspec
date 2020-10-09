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
  s.source = { :http => 'https://firebasestorage.googleapis.com/v0/b/remotedebugger-e433c.appspot.com/o/RemoteDebugger.framework.zip?alt=media&token=bb313a77-b3a8-44dd-8016-4cba4b672ead' }
  s.swift_version    = '5'

  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = 'RemoteDebugger.framework'  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
