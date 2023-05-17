//
//  WebViewController.swift
//  AppleNewsFeed
//
//  Created by jazeps.ivulis on 10/05/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var urlString: String = String()
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Web"
        guard let url = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("start nav")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("stop nav")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
