//
//  ModifyTheStyle_View.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/15.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
typealias changeBtnBlock = (UIColor) -> (Void)
class ModifyTheStyle_View: UIView {
    var global_btn:UIButton?
    var block:changeBtnBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createUI()
        
    }
    
    
    func createUI() -> Void {
        
        let bag_View = UIView()
        
        self.bk_(whenTapped: {
            UIView.animate(withDuration: 0.35, animations: {
                self.alpha = 0
            })
            
        })
        
        bag_View.backgroundColor = UIColor.RGB(R: 213, G: 213, B: 213, Alp: 1)
        self.addSubview(bag_View)
        bag_View.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(200)
        }
        
        
        
        let cut_font = self.createBtn(title: "Aa")
        cut_font.layer.borderWidth = 0.5
        cut_font.tag = 1+1000
        cut_font.addTarget(self, action: #selector(self.sendNotificationForFont(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(cut_font)
        
        let raise_font = self.createBtn(title: "Aa")
        raise_font.layer.borderWidth = 0.5
        raise_font.tag = 2+1000
        raise_font.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        raise_font.addTarget(self, action: #selector(self.sendNotificationForFont(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(raise_font)
        
        cut_font.snp.makeConstraints { (make) in
            make.left.equalTo(bag_View).offset(50)
            make.height.equalTo(35)
            make.top.equalTo(bag_View).offset(30)
        }
        
        raise_font.snp.makeConstraints { (make) in
            make.right.equalTo(bag_View).offset(-50)
            make.height.equalTo(35)
            make.top.equalTo(bag_View).offset(30)
            make.left.equalTo(cut_font.snp.right).offset(5)
            make.width.equalTo(cut_font.snp.width)
        }
        
        let white_btn = self.createBtn(title: "白色")
        white_btn.tag = 1+1000
        white_btn.backgroundColor = UIColor.RGB(R: 220, G: 220, B: 220, Alp: 1)
        white_btn.layer.borderColor = UIColor.RGB(R: 75, G: 128, B: 181, Alp: 1).cgColor
        white_btn.setTitleColor(UIColor.RGB(R: 17, G: 17, B: 17, Alp: 1), for: UIControlState.normal)
        white_btn.addTarget(self, action: #selector(self.changeColor(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(white_btn)
        
        let black_btn = self.createBtn(title: "黑色")
        black_btn.tag = 2+1000
        black_btn.backgroundColor = UIColor.RGB(R: 1, G: 1, B: 1, Alp: 1)
        black_btn.setTitleColor(UIColor.RGB(R: 208, G: 208, B: 208, Alp: 1), for: UIControlState.normal)
        black_btn.addTarget(self, action: #selector(self.changeColor(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(black_btn)
        
        let brown_btn = self.createBtn(title: "浅褐色")
        brown_btn.tag = 3+1000
        brown_btn.backgroundColor = UIColor.RGB(R: 213, G: 203, B: 180, Alp: 1)
        brown_btn.setTitleColor(UIColor.RGB(R: 58, G: 45, B: 28, Alp: 1), for: UIControlState.normal)
        brown_btn.addTarget(self, action: #selector(self.changeColor(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(brown_btn)
        
        let green_btn = self.createBtn(title: "绿色")
        green_btn.tag = 4+1000
        green_btn.backgroundColor = UIColor.RGB(R: 161, G: 196, B: 168, Alp: 1)
        green_btn.setTitleColor(UIColor.RGB(R: 44, G: 64, B: 51, Alp: 1), for: UIControlState.normal)
        green_btn.addTarget(self, action: #selector(self.changeColor(btn:)), for: UIControlEvents.touchUpInside)
        bag_View.addSubview(green_btn)
        
        white_btn.snp.makeConstraints { (make) in
            make.left.equalTo(bag_View).offset(50)
            make.height.equalTo(35)
            make.top.equalTo(cut_font.snp.bottom).offset(10)
            make.width.equalTo(green_btn.snp.width)
        }
        black_btn.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(white_btn)
            make.left.equalTo(white_btn.snp.right).offset(5)

        }

        brown_btn.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(white_btn)
            make.left.equalTo(black_btn.snp.right).offset(5)
        }
        
        green_btn.snp.makeConstraints { (make) in
            make.centerY.height.width.equalTo(white_btn)
            make.left.equalTo(brown_btn.snp.right).offset(5)
            make.right.equalTo(bag_View).offset(-50)
        }
        global_btn = white_btn
        
        if (UserDefaults.standard.object(forKey: "tag") != nil) {
            let tag = UserDefaults.standard.object(forKey: "tag") as? String
            
            if tag == "1"{
                self.changeColor(btn: white_btn)
            }
            if tag == "2"{
                self.changeColor(btn: black_btn)
            }
            if tag == "3"{
                self.changeColor(btn: brown_btn)
            }
            if tag == "4"{
               self.changeColor(btn: green_btn)
            }
        }
        
        
    
    }
    
    
    @objc func sendNotificationForFont(btn:UIButton) -> Void {
        let tag = btn.tag-1000
        
        switch tag {
        case 1:
            //下调
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cut"), object: nil)
            
            
            
            break
        case 2:
            //上调
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "up"), object: nil)
            
            break
        default:
            break
        }
    }
    
    
    @objc func changeColor(btn:UIButton) -> Void {
        let tag = btn.tag-1000
        
        if global_btn == btn{
            return
        }
        global_btn?.layer.borderColor = UIColor.RGB(R: 109, G: 109, B: 109, Alp: 0.35).cgColor
         btn.layer.borderColor = UIColor.RGB(R: 75, G: 128, B: 181, Alp: 1).cgColor
        global_btn = btn
        
        UserDefaults.standard.set(String.init(format: "%d", tag), forKey: "tag")
        
        
        switch tag {
        case 1:
            //白色
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "white"), object: nil)
            if (self.block != nil){
                self.block!(UIColor.colorWithString(colorStr: "3d3d3d"))
            }
            break
        case 2:
            //黑色
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "black"), object: nil)
            if (self.block != nil){
                self.block!(UIColor.white)
            }
            break
        case 3:
            //浅褐色
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "brown"), object: nil)
            if (self.block != nil){
                self.block!(UIColor.RGB(R: 60, G: 49, B: 36, Alp: 1))
            }
            break
        case 4:
            //绿色
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "green"), object: nil)
            if (self.block != nil){
                self.block!(UIColor.RGB(R: 55, G: 75, B: 60, Alp: 1))
            }
            break
        default:
            break
        }
    }
    
    
    
    func createBtn(title:NSString) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title as String, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.backgroundColor = UIColor.RGB(R: 209, G: 209, B: 209, Alp: 1)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.RGB(R: 109, G: 109, B: 109, Alp: 0.35).cgColor
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.setTitleColor(UIColor.colorWithString(colorStr: "3d3d3d"), for: UIControlState.normal)
        return btn
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
