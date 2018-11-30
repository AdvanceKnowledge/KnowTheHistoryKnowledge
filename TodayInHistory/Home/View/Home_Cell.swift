//
//  Home_Cell.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/13.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Home_Cell: UITableViewCell {
    var header_iv: UIImageView?
    var title_lab: UILabel?
    var date_lab: UILabel?
    var lunar_lab: UILabel?
    var des_lab: UILabel?
    var model:HomeList_Model!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.createUI()
    }
    
    func createUI() -> Void {
        
        let bag_View = UIView()
        bag_View.backgroundColor = UIColor.white
        bag_View.layer.cornerRadius = 20
        bag_View.clipsToBounds = true
        self.contentView.addSubview(bag_View)
        bag_View.snp.makeConstraints { (make) in make.top.bottom.left.right.equalTo(self.contentView).inset(UIEdgeInsets.init(top: 0, left: 12, bottom: 0, right: 12))
            
        }
        
        header_iv = UIImageView.init()
        header_iv?.backgroundColor = UIColor.colorWithString(colorStr: "f5f5f5")
        title_lab = self.create_Lab(title: "标题")
        title_lab?.textColor = UIColor.colorWithString(colorStr: "3d3d3d")
        title_lab?.font = UIFont.boldSystemFont(ofSize: 16)
        date_lab = self.create_Lab(title: "")
        lunar_lab = self.create_Lab(title: "壬寅年十月初二")
        des_lab = self.create_Lab(title: "简介")
        des_lab?.numberOfLines = 0
        
        let subArrarys = [header_iv!,
                          title_lab!,
                          date_lab!,
                          lunar_lab!,
                          des_lab!] as [Any];
        subArrarys.forEach { (obj) in
            bag_View.addSubview(obj as! UIView)
        }
        
        header_iv?.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalTo(bag_View).inset(UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 0))
            make.width.equalTo(bag_View.snp.height).offset(-24)
        })
        
        title_lab?.snp.makeConstraints({ (make) in
            make.left.equalTo((header_iv?.snp.right)!).offset(12)
            make.right.equalTo(bag_View).offset(-12)
            make.top.equalTo(header_iv!).offset(5)
            make.height.equalTo(17)
        })
        
        lunar_lab?.snp.makeConstraints({ (make) in
            make.right.bottom.equalTo(bag_View).offset(-12)
            make.height.equalTo(15)
        })
        
        date_lab?.snp.makeConstraints({ (make) in
            make.top.equalTo(lunar_lab!)
            make.right.equalTo((lunar_lab?.snp.left)!).offset(-5)
            make.height.equalTo(15)
        })
        
        des_lab?.snp.makeConstraints({ (make) in
            make.left.equalTo((header_iv?.snp.right)!).offset(12)
            make.right.equalTo(bag_View).offset(-12)
            make.top.equalTo((title_lab?.snp.bottom)!).offset(10)
            
            make.bottom.lessThanOrEqualTo(bag_View).offset(-30)
        })

    }
    
    
    func myModel(myModel:HomeList_Model) -> Void {
        model = myModel
        var urlStr:String? = String()
        if Const.IsNotStrEmpty(obj: model.pic) {
            urlStr = model.pic
        }else if Const.IsNotStrEmpty(obj: model.img) {
            urlStr = model.img
        }else{
            urlStr = ""
        }
        
        let url = URL.init(string: urlStr!)
        
        
        header_iv?.sd_setImage(with: url, placeholderImage: UIImage.init(named: "noImage"), options: .retryFailed, context: nil)
        
        
        
        title_lab?.text = model.title
        if Const.IsNotStrEmpty(obj: model.des) {
            des_lab?.text = model.des
        }else if Const.IsNotStrEmpty(obj: model.tags){
             des_lab?.text = model.tags
        }else{
            des_lab?.text = ""
        }
        
        if Const.IsNotStrEmpty(obj: model.lunar) {
            lunar_lab?.text = model.lunar
        }else if Const.IsNotStrEmpty(obj: model.reading){
            
            lunar_lab?.text = model.reading
        }else{
            lunar_lab?.text = ""
        }
    }
    
    //创建lab
    func create_Lab(title:NSString) -> UILabel {
        let lab = UILabel()
        lab.text = title as String
        lab.textColor = UIColor.colorWithString(colorStr: "a3a3a3")
        lab.font = UIFont.systemFont(ofSize: 12)
        return lab
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
