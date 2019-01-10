//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//                  http://www.icocos.cn                       //
//                 https://icocos.github.io                    //
//                https://al1020119.github.io                  //
// **************************************************************
//  ************  😂🤔 曹理鹏(梦工厂@iCocos) 🤔😂  ************  //
// **************************************************************
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//
//  Single_App
//  SwiftJavaScriptService
//
//  Created by iCocos on 2019/01/02.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class SwiftJavaScriptService.swift
// @abstract JSCore交互
// @discussion 实现JS与原生交互操作
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

// ******************************Core********************************

import UIKit
import JavaScriptCore

// 定义协议SwiftJavaScriptDelegate 该协议必须遵守JSExport协议
@objc protocol SwiftJavaScriptDelegate: JSExport {
    
    // js调用App的返回方法
    func popVC()
    
    // js调用App的showDic。传递Dict 参数
    func showDic(_ dict: [String: AnyObject])
    
    // js调用App方法时传递多个参数 并弹出对话框 注意js调用时的函数名
    func showDialog(_ title: String, message: String)
    
    // js调用App的功能后 App再调用js函数执行回调
    func callHandler(_ handleFuncName: String)
    
}

// 定义一个模型 该模型实现SwiftJavaScriptDelegate协议
@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {
    
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    /// 出栈控制器操作
    func popVC() {
        if let vc = controller {
            DispatchQueue.main.async {
                vc.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    /// 显示字典信息
    ///
    /// - Parameter dict: 字典参数
    func showDic(_ dict: [String: AnyObject]) {
        print("展示信息：", dict,"= = ")
        // 调起微信分享逻辑
    }
    
    /// 显示对应操作
    ///
    /// - Parameters:
    ///   - title: 弹窗标题
    ///   - message: 弹窗内容消息
    func showDialog(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.controller?.present(alert, animated: true, completion: nil)
    }
    
    /// 回调操作
    ///
    /// - Parameter handleFuncName: 操作回调方法
    func callHandler(_ handleFuncName: String) {
        let jsHandlerFunc = self.jsContext?.objectForKeyedSubscript("\(handleFuncName)")
        let dict = ["name": "sean", "age": 18] as [String : Any]
        let _ = jsHandlerFunc?.call(withArguments: [dict])
    }
    
}


/// JS服务
class SwiftJavaScriptService: UIViewController {
    
    var webView: UIWebView!
    var jsContext: JSContext!
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testJSContext()
        
        setWebView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// 初始化webView
    func setWebView(){
        webView = UIWebView(frame: self.view.bounds)
        view.addSubview(webView)
        webView.delegate = self
        webView.scalesPageToFit = true
        
        // 测试加载本地Html页面
        let url = Bundle.main.url(forResource: "swiftjscore", withExtension: "html")
        let request = URLRequest(url: url!)
        
        // 加载网络Html页面 请设置允许Http请求
        //let url = URL(string: "https://www.jianshu.com/u/50bd017bb4ba")
        //let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    /// 设置上下文
    func setContext(){
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        
        let model = SwiftJavaScriptModel()
        model.controller = self
        model.jsContext = context
        
        // 这一步是将SwiftJavaScriptModel模型注入到JS中，在JS就可以通过WebViewJavascriptBridge调用我们暴露的方法了。
        context.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as NSCopying & NSObjectProtocol)
        
        // 注册到网络Html页面 请设置允许Http请求
        let curUrl = self.webView.request?.url?.absoluteString  //WebView当前访问页面的链接 可动态注册
        context.evaluateScript(curUrl)
        
        context.exceptionHandler = { (context, exception) in
            print("exception：", exception as Any)
        }
        
    }
    
}

// MARK: - JSCore服务测试操作
extension SwiftJavaScriptService{
    
    /// 测试JS上下文内容设置
    func testJSContext() {
        
        // 通过JSContext执行js代码
        let context: JSContext = JSContext()
        let result1: JSValue = context.evaluateScript("1 + 3")
        print(result1)  // 输出4
        
        // 定义js变量和函数
        context.evaluateScript("var num1 = 10; var num2 = 20;")
        context.evaluateScript("function multiply(param1, param2) { return param1 * param2; }")
        
        // 通过js方法名调用方法
        let result2 = context.evaluateScript("multiply(num1, num2)")
        print(result2 ?? "result2 = nil")  // 输出200
        
        // 通过下标来获取js方法并调用方法
        let squareFunc = context.objectForKeyedSubscript("multiply")
        let result3 = squareFunc?.call(withArguments: [10, 20]).toString()
        print(result3 ?? "result3 = nil")  // 输出200
        
    }
}

// MARK: - JSCore代理方法回调
extension SwiftJavaScriptService : UIWebViewDelegate{
    
    /// WebView加载完成
    ///
    /// - Parameter webView: webView
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        setContext()
    }
}
