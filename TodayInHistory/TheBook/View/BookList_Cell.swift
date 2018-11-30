//
//  BookList_CollectionView.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class BookList_Cell: UICollectionViewCell {
    var classification_iv:UIImageView!
    var classTitle_lab: UILabel!
    var model:BookList_Model?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        createUI()
    }
    
    
    func createUI() -> Void {
        classification_iv = UIImageView()
        classification_iv.contentMode = .scaleAspectFit
        classTitle_lab = UILabel()
        classTitle_lab.text = "分类标题"
        classTitle_lab.textAlignment = .center
        classTitle_lab.font = UIFont.boldSystemFont(ofSize: 13)
        classTitle_lab.textColor = UIColor.colorWithString(colorStr: "3d3d3d")
        self.contentView.addSubview(classification_iv)
        self.contentView.addSubview(classTitle_lab)
        classTitle_lab.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.height.equalTo(16)
        }
        
        classification_iv.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(5)
            make.right.equalTo(self.contentView).offset(-5)
            make.bottom.equalTo(classTitle_lab.snp.top).offset(-5)
        }
        
    }
    
    func setBookModel(bookListModel:BookList_Model) -> Void {
        model = bookListModel
        classification_iv.image = UIImage.init(named: (model?.catalog)!)
        classTitle_lab.text = model?.catalog
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
