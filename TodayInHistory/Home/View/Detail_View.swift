//
//  Detail_View.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Detail_View: UIScrollView {
    var title_lab:UILabel?
    var detail_lab:UILabel?
    var model: Detail_Model?
    var pic_iv: UIImageView?
    
    deinit {
     NotificationCenter.default.removeObserver(self)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.cut2), name: NSNotification.Name(rawValue: "cut"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.upFont), name: NSNotification.Name(rawValue: "up"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.white), name: NSNotification.Name(rawValue: "white"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.black), name: NSNotification.Name(rawValue: "black"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.brown), name: NSNotification.Name(rawValue: "brown"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.green), name: NSNotification.Name(rawValue: "green"), object: nil)
        
        
        
    }
    
    @objc func cut2() -> Void {
        let title_currentFont = title_lab?.font
        let detail_currentFont = detail_lab?.font
        if ((title_currentFont?.pointSize)! > CGFloat(18.0)) {
            title_lab?.font = UIFont.boldSystemFont(ofSize: (title_currentFont?.pointSize)!-1)
        }
        if ((detail_currentFont?.pointSize)! > CGFloat(12.0)) {
            detail_lab?.font = UIFont.systemFont(ofSize: (detail_currentFont?.pointSize)!-1)
        }
    }
    
    @objc func upFont() -> Void {
        
        let title_currentFont = title_lab?.font
        let detail_currentFont = detail_lab?.font
        if ((title_currentFont?.pointSize)! < CGFloat(24.0)) {
            title_lab?.font = UIFont.boldSystemFont(ofSize: (title_currentFont?.pointSize)!+1)
        }
        if ((detail_currentFont?.pointSize)! < CGFloat(18.0)) {
            detail_lab?.font = UIFont.systemFont(ofSize: (detail_currentFont?.pointSize)!+1)
        }
    }
    
    @objc func white() -> Void {
        self.backgroundColor = UIColor.RGB(R: 220, G: 220, B: 220, Alp: 1)
        title_lab?.textColor = UIColor.colorWithString(colorStr: "3d3d3d")
        detail_lab?.textColor = UIColor.RGB(R: 34, G: 34, B: 34, Alp: 1)
    }
    
    @objc func black() -> Void {
        self.backgroundColor = UIColor.black
        title_lab?.textColor = UIColor.white
        detail_lab?.textColor = UIColor.white
    }
    
    @objc func brown() -> Void {
        self.backgroundColor = UIColor.RGB(R: 213, G: 203, B: 182, Alp: 1)
        title_lab?.textColor = UIColor.RGB(R: 60, G: 49, B: 36, Alp: 1)
        detail_lab?.textColor = UIColor.RGB(R: 60, G: 49, B: 36, Alp: 1)
    }
    
    @objc func green() -> Void {
        self.backgroundColor = UIColor.RGB(R: 165, G: 193, B: 166, Alp: 1)
        title_lab?.textColor = UIColor.RGB(R: 55, G: 75, B: 60, Alp: 1)
        detail_lab?.textColor = UIColor.RGB(R: 55, G: 75, B: 60, Alp: 1)
    }
    
    
    
    func createSubView() -> Void {
        title_lab = self.create_Lab(title: "")
        title_lab?.font = UIFont.boldSystemFont(ofSize: 20)
        title_lab?.numberOfLines = 0
        title_lab?.textColor = UIColor.colorWithString(colorStr: "3d3d3d")
        pic_iv = UIImageView()
        pic_iv?.isUserInteractionEnabled = true
        pic_iv?.bk_(whenTapped: {
            self.pic_iv?.showImage()
        })
        
        detail_lab = self.create_Lab(title: "")
        detail_lab?.numberOfLines = 0
        
        let content_View = UIView()
        
        self.addSubview(content_View)
        self.addSubview(pic_iv!)
        self.addSubview(title_lab!)
        self.addSubview(detail_lab!)
        content_View.snp.makeConstraints { (make) in
            make.edges.equalTo(self);
            make.width.equalTo(self);
        }
        title_lab?.snp.makeConstraints({ (make) in
            make.left.top.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-70)
        })
        
        pic_iv?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self)
            make.top.equalTo((title_lab?.snp.bottom)!).offset(30)
            make.width.lessThanOrEqualTo(self)
        })
        
        detail_lab?.snp.makeConstraints({ (make) in
            make.top.equalTo((pic_iv?.snp.bottom)!).offset(30)
            make.left.equalTo(self).offset(12)
            make.right.equalTo(self).offset(-12)
        })
        content_View.snp.makeConstraints { (make) in
            make.bottom.equalTo((detail_lab?.snp.bottom)!).offset(10)
        }
    }

    
    func setMyModel(myModel:Detail_Model) -> Void {
        model = myModel
        let url = URL.init(string: (model?.pic)!)
        pic_iv?.sd_setImage(with: url, completed: { (image, error, nil, url) in
            
        })
        
        title_lab?.text = model?.title
        detail_lab?.attributedText = self.getAttributedStringWithNormalString(normalString: model!.content as NSString, font: 14, linspace: 10)
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
    
    //创建lab
    func create_Lab(title:NSString) -> UILabel {
        let lab = UILabel()
        lab.text = title as String
        lab.textColor = UIColor.RGB(R: 34, G: 34, B: 34, Alp: 1)
        lab.font = UIFont.systemFont(ofSize: 14)
        return lab
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
