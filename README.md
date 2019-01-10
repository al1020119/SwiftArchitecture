# 梦工厂@iCocos


+ 梦工厂@iCocos
    + [http://www.icocos.cn](http://www.icocos.cn)
    + [https://icocos.github.io](https://icocos.github.io)
    + [https://al1020119.github.io](https://al1020119.github.io)

###### 项目介绍：

### 功能
```bahs
MVVM模式
Alamofire
RX响应式
骨骼动画
Swift闭包操作
JSON处理
Kingfisher图片
SnapKit适配
Bugly异常统计
友盟用户与行为统计
Mob服务：登录分享
动画：Spring，AnimationView
富文本操作
主题：Them
SQLite数据库
SwiftyUserDefaults用户配置
lottie-ios+AE
常用加密功能
Toast弹窗
各种拓展和工具
设备服务
TiledMap
用户与验证
正则匹配封装
Router路由
组件化+路由方案
动态配置脚本
红点（View+Button+TabBar+Label+ImageView）
引导页：图片，gif，视频
用户与配置持久化
网络请求，音视频播放
JS交互与相应
聊天界面封装与适配
朋友圈界面
TableView+MVVM+Cell自适应
Label打字效果
网络层封装
Jazzy文档化操作
fastlane自动化脚本打包
```

#### 涵盖以上App常用的基本功能，使用纯swift+cocopod+响应式+组件化

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
