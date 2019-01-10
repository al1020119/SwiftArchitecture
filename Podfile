# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

target 'Single_App' do

  #ReactiveX
  #pod 'RxCocoa'

  pod 'RxSwiftExt'
  pod 'NSObject+Rx'
  pod 'Action'
  pod 'Then'
  
  pod 'Closures'
  
  # RX
  pod 'RxSwift', '~> 4.4.0'
  pod 'RxDataSources'

  #NetWithRxSwift
  pod 'Moya/RxSwift'

  #JsonModel
  pod 'HandyJSON'
  pod 'SwiftyJSON'

  #ImageView
  pod 'Kingfisher'
  
  # 视频
  pod 'SnapKit'
  
  # 提示
  pod 'Toast-Swift'
  
  # 加密
  pod 'CryptoSwift'

  # AE特效
  pod 'lottie-ios'
  
  # 骨骼动画
  pod 'Spine'
  
  # UIView动画
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git'
  #pod 'SkeletonView'
  
  # 拓展
  #pod 'EZSwiftExtensions'
  
  # 数据持久化
  pod 'SQLite.swift', '~> 0.11.5'
  pod 'SwiftyUserDefaults', '4.0.0-alpha.1'
  #pod 'ViewAnimator'
  
  # 全局设备信息
  # pod 'DeviceKit', '~> 1.3'
  pod 'Hero'
  pod 'SwiftyAttributes'
  pod 'SwiftTheme'

  pod 'SwiftySound'
  
  # 网络请求专属模型-存档
  pod 'YYCache'
  #pod 'SSZipArchive'
  
  pod 'Bugly'
  
  # U-Push
  pod 'UMCCommon'
  pod 'UMCPush'
  pod 'UMCAnalytics'
  pod 'UMCSecurityPlugins'
  
  # 主模块(必须)
  pod 'mob_sharesdk'
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
  # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
  pod 'mob_sharesdk/ShareSDKPlatforms/QQ'
  pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'   #（微信sdk不带支付的命令）
  # pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull' //（微信sdk带支付的命令，和上面不带支付的不能共存，只能选择一个）

  target 'Single_AppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'Single_AppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
