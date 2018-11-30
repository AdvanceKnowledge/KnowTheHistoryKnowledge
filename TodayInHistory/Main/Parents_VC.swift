//
//  Parents_VC.swift
//  WYLSwift
//
//  Created by 王延磊 on 2018/10/30.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Parents_VC: Base_VC {

    deinit {
        print("\(type(of: self))类销毁了")
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.return_button()
        self.view.backgroundColor = UIColor.white
    }
    
    func return_button() {
        let back_Btn = UIButton.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 20, height: 20)))
        back_Btn.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        back_Btn.setBackgroundImage(UIImage.init(named: "navigation_back_hl"), for: UIControlState.normal)
        
        back_Btn.addTarget(self, action: #selector(self.backAction), for: UIControlEvents.touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: back_Btn)
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }

   

}
