//
//  BookListDetail_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class BookListDetail_VC: Parents_VC {
    var catalog_id:String!
    var page:Int!
    var pn:Int!
    var home_tab:Home_Tab!
    var models: NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        models = NSMutableArray()
        page = 0
        pn = 0
        createUI()
        getData()
    }
    
    func createUI() -> Void {
        home_tab = Home_Tab()
        
        weak var weakSelf = self
        home_tab.clickCellBlock = {(param) ->()in
            let detail_VC = BookDetail_VC()
            detail_VC.model = param
            detail_VC.navigationItem.title = param.title
            weakSelf?.pushNext_VC(vc: detail_VC)
        }
        
        home_tab.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            weakSelf?.page = 0
            weakSelf?.pn = 0
            weakSelf?.getData()
        })
        home_tab.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            weakSelf?.page = 1 + (weakSelf?.page)!
            weakSelf?.pn = (weakSelf?.page)!*30
            weakSelf?.getData()
        })
        
        self.view.addSubview(home_tab!)
        home_tab?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    
    func getData() -> Void {
        
        SVProgressHUD.show()
        
        ZHHomeNetworkRequest.getBookList_Request(withParas: ["catalog_id":catalog_id,"pn":pn]) { (posts, error) in
            
            self.home_tab.mj_footer.endRefreshing()
            self.home_tab.mj_header.endRefreshing()
            
            if (error != nil){
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            
            SVProgressHUD.showSuccess(withStatus: "加载完成")
            if (((posts! as NSDictionary).object(forKey: "result") as? NSDictionary) != nil){
                let result = ((posts! as NSDictionary).object(forKey: "result") as! NSDictionary).object(forKey: "data") as! NSArray
                
                if self.page == 0{
                    
                    if self.models.count > 0 {
                        self.models.removeAllObjects()
                    }
                    
                    if result.count > 0{
                        self.models = HomeList_Model.mj_objectArray(withKeyValuesArray: result)
                    }
                }else{
                    
                    
                    
                    if result.count > 0{
                        var models2 = NSArray()
                        models2 = HomeList_Model.mj_objectArray(withKeyValuesArray: result)
                        self.models.addObjects(from: models2 as! [Any])
                    }else{
                        SVProgressHUD.showInfo(withStatus: "已加载全部")
                    }
                }
            }else if self.page > 0{
                SVProgressHUD.showInfo(withStatus: "已加载全部")
            }
            
            self.home_tab?.myModels(myModels: self.models)
            
            
            
            
        }
    }
}
