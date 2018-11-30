
//
//  Result_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/15.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Result_VC: Parents_VC {
    var MM:NSString?
    var DD:NSString?
    weak var home_tab:Home_Tab!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "历史上的今天"
        self.createUI()
        self.getData()
    }
    
    
    func createUI() -> Void {
        home_tab = Home_Tab()
        
        weak var weakself = self
        home_tab.clickCellBlock = {(param) ->()in
            
            let detail_VC = Detail_VC()
            detail_VC.model = param
            weakself?.pushNext_VC(vc: detail_VC)
        }
        
        self.view.addSubview(home_tab!)
        home_tab?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    func getData() -> Void {
        let para = ["key":"f6b6a69de02289872c9a6bfb97c0d724","v":"1.0","month":MM,"day":DD]
        SVProgressHUD.show()
        ZHHomeNetworkRequest.home_Request(withParas: para as Any as! [AnyHashable : Any]) { (posts, error) in
            if (error != nil){
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            
            let result = (posts! as NSDictionary).object(forKey: "result") as! NSArray
            if result.count <= 0{
                SVProgressHUD.showInfo(withStatus: "暂无数据")
                self.navigationController?.perform(#selector(self.navigationController?.popViewController(animated:)), with: true, afterDelay: 0.35)
                return
            }
            
            SVProgressHUD.showSuccess(withStatus: "加载成功")
            var models = NSArray()
            models = HomeList_Model.mj_objectArray(withKeyValuesArray: result)
            self.home_tab?.myModels(myModels: models)
        }
    }
    
    

    

}
