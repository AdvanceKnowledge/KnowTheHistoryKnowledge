//
//  Detail_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit


class Detail_VC: Parents_VC {
    var detail_View: Detail_View!
    var changeFount_btn: UIButton?
    public var model:HomeList_Model?
    
//    deinit {
//        print("\(type(of: self))类销毁了")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.getData()
        self.changeFuntORBackGround()
        
        if (UserDefaults.standard.object(forKey: "tag") != nil) {
            let tag = UserDefaults.standard.object(forKey: "tag") as? String
            
            if tag == "1"{
                //白色
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "white"), object: nil)
                
                changeFount_btn?.setTitleColor(.colorWithString(colorStr: "3d3d3d"), for: UIControlState.normal)
            }
            if tag == "2"{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "black"), object: nil)
                
                changeFount_btn?.setTitleColor(UIColor.white, for: UIControlState.normal)
            }
            if tag == "3"{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "brown"), object: nil)
                
                changeFount_btn?.setTitleColor(.RGB(R: 60, G: 49, B: 36, Alp: 1), for: UIControlState.normal)
            }
            if tag == "4"{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "green"), object: nil)
                
                changeFount_btn?.setTitleColor(UIColor.RGB(R: 55, G: 75, B: 60, Alp: 1), for: UIControlState.normal)
            }
        }
        
        
    }
    //懒加载本质就是一个闭包,懒加载,在使用的时候才会调用
    lazy var modify_Style: ModifyTheStyle_View = {//CGRectMake(30, 30, 200, 50)
        
            let modify_Style = ModifyTheStyle_View()
            modify_Style.backgroundColor = UIColor.init(white: 0.0, alpha: 0.1)
            modify_Style.alpha = 0
            self.view.addSubview(modify_Style)
            modify_Style.snp.makeConstraints({ (make) in
                make.edges.equalTo(self.view)
            })
        weak var weakSelf = self
            modify_Style.block = {(param) ->()in
                weakSelf?.changeFount_btn?.setTitleColor(param, for: UIControlState.normal)
                
            }
        return modify_Style
    }()
    
    
    

    func changeFuntORBackGround() -> Void {
        
        
        changeFount_btn = UIButton()
        changeFount_btn?.setTitle("Aa", for: UIControlState.normal)
        changeFount_btn?.setTitleColor(UIColor.colorWithString(colorStr: "3d3d3d"), for: UIControlState.normal)
        changeFount_btn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        changeFount_btn?.addTarget(self, action: #selector(self.changStyle), for: UIControlEvents.touchUpInside)
        self.view.addSubview(changeFount_btn!)
        changeFount_btn?.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20+Const().kTopBarSafeHeight)
            make.right.equalTo(self.view).offset(-20)
            make.width.height.equalTo(40)
        }
    }
    func createUI() -> Void {
        detail_View = Detail_View()
        detail_View.backgroundColor = UIColor.RGB(R: 220, G: 220, B: 220, Alp: 1)
        self.view.addSubview(detail_View!)
        detail_View?.snp.makeConstraints({ (make) in
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
            make.top.equalTo(self.view)
            make.left.equalTo(self.view)
        })
    }
    
    @objc func changStyle(btn:UIButton) -> Void {
        UIView.animate(withDuration: 0.35, animations: {
            self.modify_Style.alpha = 1
        })
    }
    
    
    
    
    func getData() -> Void {
        let para = ["key":"f6b6a69de02289872c9a6bfb97c0d724","v":"1.0","id":model?.event_id as Any] as NSDictionary
        SVProgressHUD.show()
        ZHHomeNetworkRequest.detail_Request(withParas: para as! [AnyHashable : Any]) { (posts, error) in
            if (error != nil){
                SVProgressHUD.showError(withStatus: "加载失败")
                self.navigationController?.popViewController(animated: true)
                return
            }
            let error_code = (posts! as NSDictionary).object(forKey: "error_code") as! Int
            if error_code != 0{
                SVProgressHUD.showInfo(withStatus: "加载出错")
                self.navigationController?.perform(#selector(self.navigationController?.popViewController(animated:)), with: true, afterDelay: 0.35)
                return
            }
            SVProgressHUD.showSuccess(withStatus: "加载成功")
            if ((posts! as NSDictionary).object(forKey: "result") as! NSArray).count > 0{
                let result = ((posts! as NSDictionary).object(forKey: "result") as! NSArray).object(at: 0)
                let detail_model = Detail_Model.mj_object(withKeyValues: result)
                self.detail_View?.setMyModel(myModel: detail_model!)
            }
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self as UINavigationControllerDelegate;
    }

}


extension Detail_VC:UINavigationControllerDelegate{
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        if viewController.isEqual(self) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }else{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            if (self.navigationController?.delegate?.isEqual(self))! {
                self.navigationController?.delegate = nil
            }
        }
    }
}
