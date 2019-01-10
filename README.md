# @Single_App

### 公司：

> 广州积木塔科技有限公司

###### 公司介绍：

> 广州积木塔科技有限公司，致力于在文化娱乐、网络阅读(游戏)领域为用户提供最优质的服务与平台。公司核心人员来自网易、酷狗、YY等大型互联网资深从业人员，具备多年大型互联网项目管理经验，拥有雄厚的行业背景，是一个富有创造力和创新精神的团队。

###### 官网：

> http://www.52jimu.com/

###### 介绍：

> 网络阅读(游戏)服务;网络技术的研究、开发;软件开发;数字动漫制作;自然科学研究和试验发展;计算机技术开发、技术服务;电子、通信与自动控制技术研究、开发;互联网区块链技术研究开发服务;软件测试服务;软件零售;软件服务;信息电子技术服务;互联网商品零售（许可审批类商品除外）;商品批发贸易（许可审批类商品除外）; (依法须经批准的项目，经相关部门批准后方可开展经营活动)

### 项目（APP）：

> @Single_App

###### 项目介绍：

### 文档：

+ 项目Fiction_Singles 主要以 MVVM 为架构对各个模块功能与逻辑分层处理。

##### 打包流程

    + Jazzy文档生成：jazzy --min-acl internal
    + Fastlane打包上传：fastlane ios development_build

> 打包之前执行以上两步，然后完成后，修改build和version-> 选择真机 -》Clean -》Archive -》Upload to App Store

### 版本资源库

```bash

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

```
