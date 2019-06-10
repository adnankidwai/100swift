//
//  ViewController.swift
//  p4
//
//  Created by Adnan Kidwai on 6/10/19.
//  Copyright © 2019 Adnan Kidwai. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.tesla.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
         webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
//        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        // Add progressView to view and add auto layout constraints
        
        view.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressView.rightAnchor.constraint(equalTo: view.rightAnchor),
            progressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 10)
            ])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    @objc func handleOpen() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "tesla.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "github.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "instagram.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "theverge.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "reddit.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)

    }
    
    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}

