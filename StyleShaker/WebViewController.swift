//
//  WebViewController.swift
//  StyleShaker
//
//  Created by alexandre pouget on 19/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit

class WebViewController: UIViewController , UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    var t: String? = nil
    
    var b = UIDevice.currentDevice()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        if (self.t != nil){
            print(self.t!)
            let s:String = "https://www.google.fr/search?q="+self.t!.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)+"&tbm=shop"
            print(s)
            let request: NSURLRequest = NSURLRequest(URL: NSURL(string: s)!)
                
            self.webView.loadRequest(request)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
 

}
