//
//  BookList_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class BookList_VC: Base_VC {
    var hotClass_ColView: UICollectionView!
    
    var models:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        models = NSArray()
        self.navigationItem.title = "图书"
//        let model = BookList_Model()
//        model.id = "242"
//        model.catalog = "中国文学"
//        models = [model]
        createUI()
        getBookCatalog()
    }
    
    
    func createUI() -> Void {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.itemSize = CGSize.init(width: (Const().SCREEN_WIDTH-30)/3, height: 165)
        
        hotClass_ColView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        hotClass_ColView.backgroundColor = UIColor.colorWithString(colorStr: "f5f5f5")
        hotClass_ColView.dataSource = self
        hotClass_ColView.delegate = self
        
        hotClass_ColView.showsVerticalScrollIndicator = false;
        hotClass_ColView.register(BookList_Cell.self, forCellWithReuseIdentifier: "homeCell")
        self.view.addSubview(hotClass_ColView)
        hotClass_ColView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
    
    
    func getBookCatalog() -> Void {
        
        
        SVProgressHUD.show()
        
        ZHHomeNetworkRequest.getBookCatalog_Request(withParas: nil) { (posts, error) in
            if (error != nil){
                SVProgressHUD.showError(withStatus: "加载数据失败")
                return
            }
            let result = (posts! as NSDictionary).object(forKey: "result") as! NSArray
            
            if result.count != 0{
                self.models = BookList_Model.mj_objectArray(withKeyValuesArray: result)
            }
            self.hotClass_ColView.reloadData()
            SVProgressHUD.showSuccess(withStatus: "加载完成")
        }
        
    }

}



extension BookList_VC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (self.models?.count)!
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! BookList_Cell
        cell.backgroundColor = UIColor.white
        cell.setBookModel(bookListModel: models?.object(at: indexPath.row) as! BookList_Model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bookListDetail_VC = BookListDetail_VC()
        let model = models?.object(at: indexPath.row) as! BookList_Model
        bookListDetail_VC.catalog_id = model.id
        bookListDetail_VC.navigationItem.title = model.catalog
        self.pushNext_VC(vc: bookListDetail_VC)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    
}
