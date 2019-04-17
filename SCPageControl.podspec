Pod::Spec.new do |s|
  s.name             = 'SCPageControl'
  s.version          = '0.4.0'
  s.summary          = 'SCPageControl is pagecontrol'
  s.description      = 'A short description of SCPageControl. It animation'

  s.homepage         = 'https://github.com/myoungsc/SCPageControl'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'myoung' => 'myoungsc.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/myoungsc/SCPageControl.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'SCPageControl/Classes/**/*'

end
