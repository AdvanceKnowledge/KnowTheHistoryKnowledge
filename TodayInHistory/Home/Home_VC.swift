//
//  Home_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/13.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Home_VC: Base_VC {

    var home_tab:Home_Tab!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createSearch()
        self.createUI()
        self.getData()

    }
    
    
    
    func createUI() -> Void {
        home_tab = Home_Tab()
        
        weak var weakSelf = self
        home_tab.clickCellBlock = {(param) ->()in
            let detail_VC = Detail_VC()
            detail_VC.model = param
            weakSelf?.pushNext_VC(vc: detail_VC)
        }
        
        self.view.addSubview(home_tab!)
        home_tab?.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    
    
    func createSearch() -> Void {
        
        let navHeight = self.navigationController?.navigationBar.frame.size.height
        
        let searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: (navHeight!-35)/2, width: (self.navigationController?.navigationBar.frame.size.width)!*0.9, height: 35))
        searchBar.placeholder = "搜索历史上的某一天"
        searchBar.delegate = self
        let titView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (self.navigationController?.navigationBar.frame.size.width)!*0.9, height: navHeight!))
        titView.addSubview(searchBar)
        self.navigationItem.titleView = titView
    }
    
    
    func getData() -> Void {
        
        let month = self.getDateWith(type: "MM")
        let day = self.getDateWith(type: "dd")
        
        SVProgressHUD.show()
        let para = ["key":"f6b6a69de02289872c9a6bfb97c0d724","v":"1.0","month":month,"day":day]
        ZHHomeNetworkRequest.home_Request(withParas: para ) { (posts, error) in
            
            if (error != nil){
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            SVProgressHUD.showSuccess(withStatus: "加载成功")
            let result = (posts! as NSDictionary).object(forKey: "result")
            var models = NSArray()
            models = HomeList_Model.mj_objectArray(withKeyValuesArray: result)
            self.home_tab?.myModels(myModels: models)
        }
    }
    
    
}


extension Home_VC:UISearchBarDelegate,UINavigationControllerDelegate{
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
        let search_VC = Search_VC()
        self.pushNext_VC(vc: search_VC)
        return false
    }
    
    
    
    
}
