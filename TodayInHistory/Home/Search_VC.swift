//
//  Search_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/13.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class Search_VC: Parents_VC {
    var calenarView:SoCalendarView?
    var navTitleLab:UILabel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "选择日期"
        self.createUI()
    }
    
    
    func createUI() -> Void {
        
        calenarView = SoCalendarView.init(soCalendarViewWithFrame: CGRect.init(x: 0, y: 0, width: Const().SCREEN_WIDTH, height: 350))
        calenarView?.deleagte = self
        weak var weakself = self
        calenarView?.changeMonthBlcok = {(year,month)  -> ()in
            if (month < 10) {
                weakself?.navTitleLab?.text = NSString.init(format: "历史上的今天(%d-0%d)", year,month) as String

            }else{
                weakself?.navTitleLab?.text = NSString.init(format: "历史上的今天(%d-%d)", year,month) as String

            }
            
        }
        
        self.view.addSubview(calenarView!)
        
        navTitleLab = UILabel()
        navTitleLab?.text = NSString.init(format: "历史上的今天(%@)", self.getDateWith(type: "YYYY-MM")) as String
        navTitleLab?.font = UIFont.systemFont(ofSize: 18)
        
        navTitleLab?.textColor = UIColor.colorWithString(colorStr: "ababab")

        
        self.view.addSubview(navTitleLab!)
        navTitleLab?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(calenarView!.snp.bottom).offset(30)
//            make.width.equalTo(100)
        })
        
        let last_btn = UIButton()
        last_btn.setImage(UIImage.init(named: "lastMonth"), for: UIControlState.normal)
        last_btn.tag = 1+1000
        last_btn.addTarget(self, action: #selector(self.changeMonth(btn:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(last_btn)
        last_btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navTitleLab!)
            make.right.equalTo((navTitleLab?.snp.left)!).offset(-10)
            make.width.height.equalTo(19)
        }
        
        let next_btn = UIButton()
        next_btn.setImage(UIImage.init(named: "nextMonth"), for: UIControlState.normal)
        next_btn.tag = 2+1000
        next_btn.addTarget(self, action: #selector(self.changeMonth(btn:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(next_btn)
        
        next_btn.snp.makeConstraints { (make) in
            make.centerY.equalTo(navTitleLab!)
            make.left.equalTo((navTitleLab?.snp.right)!).offset(10)
            make.width.height.equalTo(19)
        }
        
        
    }
    
    @objc func changeMonth(btn:UIButton) -> Void {
        let tag = btn.tag - 1000
        switch tag {
        case 1:
            //上月
            calenarView?.rightHandleSwipe(nil)
            break
        case 2:
            //下月
            calenarView?.leftHandleSwipe(nil)
            break
        default:
            break
        }
    }
    
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.delegate = self as UINavigationControllerDelegate;
//    }

}

extension Search_VC:UINavigationControllerDelegate{
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

extension Search_VC:SoCalendarViewDelegate{
    func soCalendarView(_ calendarView: SoCalendarView!, selectCalendarDay calendar: SoCalendar!) {
        let date = calendar.nsDate()
        let dateFormatter1 = DateFormatter.init()
        
        dateFormatter1.dateFormat = "MM"
        let MM = dateFormatter1.string(from: date! as Date)
        
        dateFormatter1.dateFormat = "dd"
        let DD = dateFormatter1.string(from: date! as Date)
        
        let result_VC = Result_VC()
        result_VC.MM = MM as NSString
        result_VC.DD = DD as NSString
        self.pushNext_VC(vc: result_VC)
    }
    
    
}
