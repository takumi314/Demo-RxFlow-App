//
//  WebViewController.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 03/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import WebKit
import Reusable

class WebViewController: UIViewController, ViewModelBased, StoryboardBased {

    @IBOutlet weak var contentView: UIView!

    var viewModel: WebViewViewModel!

    private var webView: WKWebView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private methods

    private func setupWebView() {
        let webView = WKWebView(frame: .zero)

        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        self.webView = webView
    }

}


