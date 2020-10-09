#
# Be sure to run `pod lib lint RemoteDebugger.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'RemoteDebugger-SDK'
  s.version          = '0.1.0'
  s.summary          = 'RemoteDebugger - View logs in runtime.'
  s.description      = <<-DESC
RemoteDebugger allows you to view logs in runtime.
RemoteDebugger-SDK - allows you to add logs with different destinations, levels, tags and more. 
                       DESC
  s.homepage         = 'https://github.com/yogevbar/RemoteDebugger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yogev Barber' => 'yogevbarber@gmail.com' }
  s.source = { :http => 'https://firebasestorage.googleapis.com/v0/b/remotedebugger-e433c.appspot.com/o/RemoteDebugger%2Fv0.1.0%2FRemoteDebugger.framework.zip?alt=media&token=61bccc7f-a349-45e2-9a93-c3bff90da5bf' }
  s.swift_version    = '5'

  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = 'RemoteDebugger.framework'  
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
