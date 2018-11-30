//
//  Home_Tab.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/13.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit
typealias clickCell = (HomeList_Model) -> (Void)
class Home_Tab: UITableView {
    var models:NSArray?
    var clickCellBlock: clickCell?
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        models = NSArray()
        self.backgroundColor = UIColor.colorWithString(colorStr: "f5f5f5")
        self.tableFooterView = UIView()
        self.register(Home_Cell.self, forCellReuseIdentifier: "Home_Cell")
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func myModels(myModels:NSArray) -> Void {
        models = myModels
        self.reloadData()
    }
    
    
    
}
extension Home_Tab:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (models?.count)!
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home_Cell")  as! Home_Cell
        let model = models?.object(at: indexPath.section) as! HomeList_Model
        
        cell.myModel(myModel: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
            view.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else{
            return 0.001
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view:UIView = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    //点击cell,进入到详情页
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if ((self.clickCellBlock) != nil) {
            self.clickCellBlock!(models?.object(at: indexPath.section) as! HomeList_Model)
        }
    }
    
   
    
    
    
   
    
}
