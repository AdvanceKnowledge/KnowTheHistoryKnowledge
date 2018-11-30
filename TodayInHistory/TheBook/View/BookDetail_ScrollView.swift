//
//  BookDetail_ScrollView.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

typealias clickBuyBtn = (String,String) -> (Void)

class BookDetail_ScrollView: UIScrollView {
    var model:HomeList_Model!
    var imageView:UIImageView!
    var title_lab:UILabel!
    
    var reading_lab:UILabel!
    var catalog_lab:UILabel!
    var sub2_lab:UILabel!
    var contentView:UIView!
    
    var urls:NSMutableDictionary!
    
    
    var block: clickBuyBtn!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        urls = NSMutableDictionary.init(capacity: 3)
        createUI()
    }
    
    func createUI() -> Void {
        
        contentView = UIView()
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        imageView.isUserInteractionEnabled = true
        weak var weakSelf = self
        imageView.bk_(whenTapped: {
            weakSelf?.imageView.showImage()
        })
        
        
        title_lab = UILabel()
        title_lab.textColor = UIColor.colorWithString(colorStr: "181818")
        title_lab.font = UIFont.boldSystemFont(ofSize: 18)
        title_lab.adjustsFontSizeToFitWidth = true
        
        reading_lab = UILabel()
        reading_lab.textColor = UIColor.colorWithString(colorStr: "8c8c8c")
        reading_lab.font = UIFont.systemFont(ofSize: 12)
        
        catalog_lab = UILabel()
        catalog_lab.textColor = UIColor.colorWithString(colorStr: "8c8c8c")
        catalog_lab.font = UIFont.systemFont(ofSize: 12)
        
        let line_view = UIView()
        line_view.backgroundColor = UIColor.RGB(R: 236, G: 237, B: 240, Alp: 1)
        self.addSubview(line_view)
        
        
        sub2_lab = UILabel()
        sub2_lab.textColor = UIColor.colorWithString(colorStr: "3d3d3d")
        sub2_lab.font = UIFont.systemFont(ofSize: 13)
        sub2_lab.numberOfLines = 0
        
        
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
            make.width.equalTo(self);
        }
        
        let introduce_lab = UILabel()
        introduce_lab.textColor = UIColor.colorWithString(colorStr: "181818")
        introduce_lab.font = UIFont.boldSystemFont(ofSize: 15)
        introduce_lab.text = "内容介绍"
        let subViews = [
            imageView,
            title_lab,
            reading_lab,
            catalog_lab,
            introduce_lab,
            sub2_lab] as [Any]
        for subView in subViews {
            self.addSubview(subView as! UIView)
        }
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(165)
        }
        
        title_lab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18)
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.height.equalTo(18)
            make.right.lessThanOrEqualTo(self).offset(-10)
        }
        
        catalog_lab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18)
            make.top.equalTo(title_lab.snp.bottom).offset(20)
            make.height.equalTo(18)
        }
        
        
        reading_lab.snp.makeConstraints { (make) in
            make.left.equalTo(catalog_lab.snp.right).offset(18)
            make.centerY.equalTo(catalog_lab.snp.centerY)
            make.height.equalTo(18)
        }
        
        line_view.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(catalog_lab.snp.bottom).offset(20)
            make.height.equalTo(1)
        }
        
        introduce_lab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18)
            make.top.equalTo(line_view.snp.bottom).offset(20)
            make.height.equalTo(18)
        }
        
        sub2_lab.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(18)
            make.right.equalTo(self).offset(-18)
            make.top.equalTo(introduce_lab.snp.bottom).offset(10)
        }
        
        

    }
    
    
    func setMyModel(myModel:HomeList_Model) -> Void {
        model = myModel
        
        let url = URL.init(string: myModel.img!)
         imageView?.sd_setImage(with: url, placeholderImage: UIImage.init(named: "noImage"), options: .retryFailed, context: nil)
        title_lab.text = model.sub1
        reading_lab.text = model.reading
        catalog_lab.text = model.catalog
        sub2_lab.attributedText = self.getAttributedStringWithNormalString(normalString: model.sub2! as NSString, font: 13, linspace: 5)
        if model.buyUrls.count > 0 {
            
            let buyType = UILabel()
            buyType.textColor = UIColor.colorWithString(colorStr: "181818")
            buyType.font = UIFont.boldSystemFont(ofSize: 15)
            buyType.text = "购买方式"
            self.addSubview(buyType)
            buyType.snp.makeConstraints({ (make) in
                make.left.equalTo(self).offset(18)
                make.top.equalTo(sub2_lab.snp.bottom).offset(20)
                make.height.equalTo(18)
            })
            
            
            
            
            var lastBtn:UIButton?
            let width = (Const().SCREEN_WIDTH - CGFloat((model.buyUrls.count - 1)*20 + 40))/CGFloat(model.buyUrls.count)
            
            for subStr in model.buyUrls {
                let key = (subStr as! String).mySubstring(before: ":")
                let value = (subStr as! String).mySubstring(after: ":")
                urls.setObject(value, forKey: key as NSCopying)
                
                let buyButton = UIButton()
                buyButton.setTitle(key, for: .normal)
                buyButton.setTitleColor(.clear, for: .normal)
                buyButton.layer.cornerRadius = 10
                buyButton.clipsToBounds = true
//                buyButton.imageView?.contentMode = .scaleAspectFit
                
                buyButton.setBackgroundImage(UIImage.init(named: key), for: .normal)
                buyButton.addTarget(self, action: #selector(self.pushWebView(btn:)), for: .touchUpInside)
                
                self.addSubview(buyButton)
                buyButton.snp.makeConstraints({ (make) in
                    make.left.equalTo(lastBtn != nil ? (lastBtn?.snp.right)!:self).offset(20)
                    make.height.equalTo(width*(58/142))
                    make.width.equalTo(width)
                    make.top.equalTo(buyType.snp.bottom).offset(20)
                })
                lastBtn = buyButton
            }
            
            contentView.snp.makeConstraints { (make) in
                make.bottom.equalTo((lastBtn?.snp.bottom)!).offset(30)
            }
        }else{
            contentView.snp.makeConstraints { (make) in
                make.bottom.equalTo(sub2_lab.snp.bottom)
            }
        }
    }
    
    
    @objc func pushWebView(btn:UIButton) -> Void {
        
        
        let url = urls.object(forKey: btn.currentTitle as Any)
        if (self.block != nil) {
            self.block(url as! String,btn.currentTitle!)
        }
    }
    
    
    
    //设置行间距
    func getAttributedStringWithNormalString(normalString:NSString,font:CGFloat,linspace:CGFloat) -> NSAttributedString {
        
        if normalString == "" {
            
            return NSAttributedString.init(string: "", attributes: [:])
        }
        let attributeDict = NSMutableDictionary.init(capacity: 3)
        attributeDict.setValue(UIFont.systemFont(ofSize: font), forKey: NSAttributedStringKey.font.rawValue)
        let paraStyle = NSMutableParagraphStyle.init()
        paraStyle.lineSpacing = linspace
        attributeDict.setValue(paraStyle, forKey: NSAttributedStringKey.paragraphStyle.rawValue)
        return NSAttributedString.init(string: normalString as String, attributes: attributeDict as? [NSAttributedStringKey : Any])
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
