//
//  TYNavigationController.swift
//  FullPanDemo
//
//  Created by Tiny on 2017/5/23.
//  Copyright © 2017年 LOVEGO. All rights reserved.
//

import UIKit

class TYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //利用运行时动态拿到系统的侧滑手势 action + target  手动创建一个全屏的pan手势，响应事件用系统的
        //拿到interactivePopGestureRecognizer这个对象里面全部的属性
//        var count:UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//             //拿到ivar指针
//            let nameP = ivar_getName(ivars[Int(i)])
//            //根据指针找到对应的属性的字符串
//            let name = String(cString: nameP!)
//            print(name)
//        }
//        
        guard  let targets = interactivePopGestureRecognizer?.value(forKey: "_targets") as?[AnyObject] else {
            return
        }
        //拿到 action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7ff515c0dc80>
        
        let dict = targets[0]
        //拿到action
        let target = dict.value(forKey: "target") as Any
        //通过字典无法拿到action，这里通过Selector方法包装action
        let action = Selector(("handleNavigationTransition:"))

        //拿到target action 创建pan手势并添加到全屏view上
        let gesture = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(gesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
