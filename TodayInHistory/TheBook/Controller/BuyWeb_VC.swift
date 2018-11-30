//
//  BuyWeb_VC.swift
//  TodayInHistory
//
//  Created by 王延磊 on 2018/11/27.
//  Copyright © 2018 追@寻. All rights reserved.
//

import UIKit

class BuyWeb_VC: Parents_VC {
    var url: String!
    var model:HomeList_Model!
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()

    }
    
    func createUI() -> Void {
        let url_url = URL.init(string: url)
        let webView = UIWebView()
        webView.delegate = self
        let request = URLRequest.init(url: url_url!)
        webView.loadRequest(request as URLRequest)
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    
    
}

extension BuyWeb_VC:UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
