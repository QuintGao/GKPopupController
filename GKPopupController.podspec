Pod::Spec.new do |s|
  s.name             = 'GKPopupController'
  s.version          = '1.0.0'
  s.summary          = 'A short description of GKPopupController.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/QuintGao/GKPopupController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QuintGao' => '1094887059@qq.com' }
  s.source           = { :git => 'https://github.com/QuintGao/GKPopupController.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'GKPopupController/**/*'
end
