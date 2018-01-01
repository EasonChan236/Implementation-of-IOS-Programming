//
//  WebController.swift
//  WorldTrotter
//
//  Created by EasonChan on 12/23/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit
import WebKit

class WebController: UIViewController{
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("WebController loaded its view")
    }
    
    override func loadView()
    {
        super.loadView()
        
        webView = WKWebView ()
        view = webView
        
        let url = NSURL (string: "https://forums.bignerdranch.com")
        let request = NSURLRequest (url: url! as URL)
        webView.load (request as URLRequest)
        print ("Loaded request")
    }
}
