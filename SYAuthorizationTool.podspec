
Pod::Spec.new do |s|
  s.name             = 'SYAuthorizationTool'
  s.version          = '1.0'
  s.summary          = '权限管理工具'
  s.description      = "包含位置，图片，相机，相册"
  s.homepage         = 'https://github.com/shenyuan000/SYAuthorizationTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shenyuan000' => 'jixiedaheng@163.com' }
  s.source           = { :git => 'https://github.com/shenyuan000/SYAuthorizationTool.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'SYAuthorizationTool/Classes/**/*'
  s.requires_arc = true
end
