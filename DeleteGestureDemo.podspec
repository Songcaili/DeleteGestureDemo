Pod::Spec.new do |s|
s.name         = "DeleteGestureDemo" # 项目名称
s.version      = "0.1.1"        # 版本号 与 你仓库的 标签号 对应
s.license      = "MIT"          # 开源证书
s.summary      = "私人pod代码" # 项目简介

s.homepage     = "https://github.com/Songcaili/DeleteGestureDemo.git" # 仓库的主页
s.source       = { :git => "https://github.com/Songcaili/DeleteGestureDemo.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
s.source_files = "DeleteGestureDemo/DeleteGestureDemo/*.{h,m,framework}"
s.requires_arc = true # 是否启用ARC
s.platform     = :ios, "7.0" #平台及支持的最低版本
# s.frameworks   = "UIKit", "Foundation" #支持的框架
# s.dependency   = "AFNetworking" # 依赖库

# User
s.author             = { "songcaili" => "2496900710@qq.com" } # 作者信息

s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
s.pod_target_xcconfig = {
#    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'OTHER_LDFLAGS' => '-ObjC',
    'COMPILER_INDEX_STORE_ENABLE' => 'NO',
#    'LLVM_LTO[config=Debug][sdk=*][arch=*]' => 'NO',
#    'LLVM_LTO[config=Release][sdk=*][arch=*]' => 'YES_THIN',
     'GCC_OPTIMIZATION_LEVEL[config=Debug][sdk=*][arch=*]' => '0',
     'GCC_OPTIMIZATION_LEVEL[config=Release][sdk=*][arch=*]' => 'z',
     'ASSETCATALOG_COMPILER_OPTIMIZATION'=>'space',
     'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES'=>'YES',
}

# s.dependency 'BURelyFoundation/NETWork'
s.vendored_frameworks = "DeleteGestureDemo/DeleteGestureDemo/BUFoundation.framework"

end

