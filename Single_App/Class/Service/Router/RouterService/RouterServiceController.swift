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
//  RouterPathServiceController
//
//  Created by iCocos on 2019/01/03.
//  Copyright © 2019年 iCocos. All rights reserved.
//
// @class RouterPathServiceController.swift
// @abstract 路由控制器
// @discussion 实现路由控制器服务显示
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit

/// 路由控制服务
enum RouterPathService: RouterPathableService {
    
    case avc
    case bvc(String)
    case rvc(Demo)
    
    /// 类型
    var any: AnyClass {
        switch self {
        case .avc:
            return AVC.self
        case .bvc:
            return BVC.self
        case .rvc:
            return RVC.self
        }
    }
    
    /// 参数
    var params: RouterServiceParameter? {
        switch self {
        case .bvc(let name):
            return ["name":name]
        case .rvc(let demo):
            return ["demo":demo]
        default:
            return nil
        }
    }
    
}


/// 路由控制器
class RouterServiceController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
    }
    
    /// 正常push
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func nomalPush(_ sender: Any) {
        RouterService.open(RouterPathService.avc)
    }
    
    
    /// push参数
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func pushWithParams(_ sender: Any) {
        let demo = Demo(name: "RVC title", id: 1)
        RouterService.open(RouterPathService.rvc(demo))
    }
    
    /// x弹窗控制
    ///
    /// - Parameter sender: 操作按钮
    @IBAction func xpresent(_ sender: Any) {
        RouterService.open(RouterPathService.bvc("BVC title"), present: true)
    }
    
}


// MARK: - Router控制服务
extension RouterServiceController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RouterServiceCell
        return cell
    }
    
}

class AVC: UIViewController, Routable{
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    
    /// 初始化Router参数
    ///
    /// - Parameter params: 参数模型
    static func initWithParams(params: RouterServiceParameter?) -> UIViewController {
        return AVC()
    }
    
}

class BVC: UIViewController, Routable{
    
    // MARK: - /************************View life************************/
    /// View加载控制，通用生命周期
    ///
    /// - viewDidLoad:
    ///   - 初始化UI，变量，属性，相关配置
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }
    let name: String
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化Router参数
    ///
    /// - Parameter params: 参数模型
    static func initWithParams(params: RouterServiceParameter?) -> UIViewController {
        guard let name = params?["name"] as? String else {
            fatalError("params is wrong")
        }
        let bvc = BVC(name: name)
        return bvc
    }
    
}

/// Demo类型
struct Demo {
    var name: String
    var id: Int
}

class RVC: UIViewController {
    
    let demo:Demo
    init(demo:Demo) {
        self.demo = demo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        // MARK: - /************************View life************************/
        /// View加载控制，通用生命周期
        ///
        /// - viewDidLoad:
        ///   - 初始化UI，变量，属性，相关配置
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = demo.name
    }
    
}

// MARK: - RVC-Router初始化参数
extension RVC: Routable {
    
    /// 初始化Router参数
    ///
    /// - Parameter params: 参数模型
    static func initWithParams(params: RouterServiceParameter?) -> UIViewController {
        guard let demo = params?["demo"] as? Demo else {
            fatalError("params is wrong")
        }
        let rvc = RVC(demo: demo)
        return rvc
    }
    
}





















