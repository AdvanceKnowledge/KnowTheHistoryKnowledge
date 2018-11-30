//
//  Main_Tab_VC.swift
//  WYLSwift
//
//  Created by 王延磊 on 2018/10/25.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Main_Tab_VC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = UIColor.white
        self.addVC()
    }
    func addVC() {
        
        let vc = Home_VC()
        self.setVCTabBarItem(title: "历史的今天", selectedImage: "home_highlight", image: "home_normal", vc: vc)
        let nav1 = TYNavigationController.init(rootViewController: vc)
        let bookList_VC = BookList_VC()
        self.setVCTabBarItem(title: "图书", selectedImage: "message_highlight", image: "message_normal", vc: bookList_VC)
        let nav2 = TYNavigationController.init(rootViewController: bookList_VC)
        
        self.addChildViewController(nav1)
        self.addChildViewController(nav2)
    }
    
//    设置TabBar样式
    func setVCTabBarItem(title:NSString,selectedImage:NSString,image:NSString,vc:UIViewController) {
        vc.tabBarItem.title = title as String
        vc.tabBarItem.selectedImage = UIImage.init(named: selectedImage as String)
        vc.tabBarItem.image = UIImage.init(named: image as String)
        vc.tabBarItem.setTitleTextAttributes(NSDictionary.init(object:  UIColor.black, forKey: NSAttributedStringKey.foregroundColor as NSCopying) as? [NSAttributedStringKey : Any], for: UIControlState.selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
