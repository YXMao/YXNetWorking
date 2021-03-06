Pod::Spec.new do |s|

  s.name         = "YXNetWorking"
  s.version      = "1.0.0"
  s.summary      = "It is a delightful network framework."
  s.description  = <<-DESC
                   YXNetWorking is a simple network framework based on AFNetWorking
                   DESC

  s.homepage     = "https://github.com/YXMao/YXNetWorking"
  s.license      = "MIT"
  s.author       = { "maoyuxiang" => "295911401@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/YXMao/YXNetWorking.git", :tag => "#{s.version}" }
  s.source_files  = "YXNetWorking/*.{h,m}"
  s.resources = "YXNetWorking/SourcesBundle.bundle"
  s.requires_arc = true
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.dependency 'MJExtension'
  s.dependency 'MBProgressHUD', '~> 0.9.2'
  s.dependency "AFNetworking", '~> 3.1.0'

end
