//
//  ExtensionTools.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/14.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class ExtensionTools: NSObject {

}

extension UIColor{
    
    public static func RGB(R:Float,G:Float,B:Float,Alp:Float) -> UIColor {
        
        return UIColor.init(red: CGFloat(R/255.0), green: CGFloat(G/255.0), blue: CGFloat(B/255.0), alpha: CGFloat(Alp));
    }
    
    public static func colorWithString(colorStr:NSString) -> UIColor{
        var cString = colorStr.trimmingCharacters(in: CharacterSet.ReferenceType.whitespacesAndNewlines) as String
        if (cString.count < 6) {
            return UIColor.clear
        }
        if cString.hasPrefix("0X") {
            cString  = String(cString[cString.index(cString.startIndex, offsetBy: 2)...])
        }
        if cString.hasPrefix("#") {
            cString  = String(cString[cString.index(cString.startIndex, offsetBy: 1)...])
        }
        
        if (cString.count != 6) {
            return UIColor.clear
        }
        let rstr = cString.mySubstring(start: 0, length: 2)
        let gstr = cString.mySubstring(start: 2, length: 2)
        let bstr = cString.mySubstring(start: 4, length: 2)
        
        var R = CUnsignedInt(),G = CUnsignedInt(),B = CUnsignedInt()
        Scanner.init(string: rstr).scanHexInt32(&R)
        Scanner.init(string: gstr).scanHexInt32(&G)
        Scanner.init(string: bstr).scanHexInt32(&B)
        return UIColor.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: CGFloat(1));
    }
    
}

extension String {
    
    /*
     在index = 0开始截取字符串到指定下标位置,(不包含下标)
     */
    func mySubstring(to index:NSInteger) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    /*
     在 index = index 指定下标开始截取字符串,(包含指定下标)
     */
     func mySubstring(from index:NSInteger) -> String{
     return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    /*
     截取指定开始位置,指定长度
     */
    func mySubstring(start location:NSInteger, length long:NSInteger) -> String {
        var len = long
        if len == -1 {
            len = self.count - location
        }
        let st = self.index(startIndex, offsetBy:location)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    /*
     第一个满足指定字符条件前边的文字,(不包含指定字符)
     */
    func mySubstring(before str:Character) -> String {
        return String(self[..<(self.index(of: str) ?? self.endIndex)])
    }
    /*
     第一个满足指定字符条件后边的字,(不包含指定字符)
     */
    func mySubstring(after str:Character) -> String {
        let st = self.index((self.index(of: str) ?? self.endIndex), offsetBy: 1)
        return String(self[st..<self.endIndex])
    }
}
extension UIImageView{
    
    func showImage() -> Void {
        let image = self.image
        let window = UIApplication.shared.keyWindow
        let backgroundView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: (window?.frame.size.width)!, height: (window?.frame.size.height)!))
        
        backgroundView.backgroundColor = UIColor.init(white: 0.441, alpha: 1.00)
        backgroundView.alpha = 0.0
        
        
        let imageView = UIImageView.init(frame: self.convert(self.bounds, to: window))
        imageView.image = image
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.tag = 1
        backgroundView.addSubview(imageView)
        window?.addSubview(backgroundView)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.hideImage(tap:)))
        backgroundView.addGestureRecognizer(tap)
        
        UIView.animate(withDuration: 0.3, animations: {
            imageView.center = backgroundView.center
            backgroundView.alpha = 1
        }) { (finished) in
        }
    }
    
    @objc func hideImage(tap:UITapGestureRecognizer) -> Void {
        let backgroundView = tap.view
        let imageView = backgroundView?.viewWithTag(1) as! UIImageView
        let window = UIApplication.shared.keyWindow
        UIView.animate(withDuration: 0.3, animations: {
            imageView.frame = self.convert(self.bounds, to: window)
            backgroundView?.alpha = 0
        }) { (finished) in
            backgroundView?.removeFromSuperview()
        }
    }
    
}

extension NSObject{
    func getDateWith(type:NSString) -> NSString {
        
        let currentDate = NSDate()
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = type as String!
        let dateString = dateFormatter.string(from: currentDate as Date)
        return dateString as NSString
    }
}








