//
//  BookDetail_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class BookDetail_VC: Parents_VC {
    var model:HomeList_Model!
    override func viewDidLoad() {
        super.viewDidLoad()
        createIU()
    }
    
    func createIU() -> Void {
        let detailView = BookDetail_ScrollView()
        self.view.addSubview(detailView)
        detailView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        detailView.setMyModel(myModel: model)
        
        detailView.block = {(param,param2) -> ()in
            let buy_VC = BuyWeb_VC()
            buy_VC.url = param
            buy_VC.model = self.model
            buy_VC.navigationItem.title = param2
            self.pushNext_VC(vc: buy_VC)
        }
    }
}
