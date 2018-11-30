//
//  Base_VC.swift
//  WYLSwift
//
//  Created by 王延磊 on 2018/10/30.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
import SnapKit
class Base_VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        
    }

    func pushNext_VC(vc:UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
        
    }
    

   

}
