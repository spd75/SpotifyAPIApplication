//
//  SignInView.swift
//  SpotifyApp
//
//  Created by Sergio Diaz on 9/12/20.
//  Copyright © 2020 Sergio Diaz. All rights reserved.
//

import UIKit
import WebKit


class SignInViewController: UIViewController, WKNavigationDelegate {
    
    let padding: CGFloat = 10
    var delegate: UpdateCollection?
    
    var webView: WKWebView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView = WKWebView(frame: view.bounds)
        
        AuthenticationHandler.requestLogin(onCompletion: { requestString in
            let url = URL(string: requestString)
            let request = URLRequest(url: url!)
            self.webView.load(request)
        })
        
        webView.navigationDelegate = self
        webView.tag = 5
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .black
        webView.allowsBackForwardNavigationGestures = true

        view.addSubview(webView)
            
        setupConstraints()
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        let newUrl = webView.url?.string ?? ""
        
        if newUrl.contains("?code=") {
            let i: String.Index = newUrl.firstIndex(of: "=") ?? String.Index(encodedOffset: 0)
            let iAdjusted = newUrl.index(i, offsetBy: 1)
            let code = newUrl.suffix(from: iAdjusted)
            AuthenticationHandler.code = String(code)
            AuthenticationHandler.getAuthToken(completion: {
                NetworkHandler.getUserProfile(completion: {
                    self.delegate?.updateCollectionType()
                })
            })
            
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let newUrl = webView.url?.string ?? ""
        
        if newUrl.contains(AuthenticationHandler.redirect_uri) {
            dismiss(animated: true, completion: nil)
        }
    }

    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
