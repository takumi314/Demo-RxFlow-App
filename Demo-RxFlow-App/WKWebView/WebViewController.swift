//
//  WebViewController.swift
//  Demo-RxFlow-App
//
//  Created by NishiokaKohei on 03/12/2018.
//  Copyright © 2018 Takumi. All rights reserved.
//

import WebKit
import RxWebKit
import Reusable

class WebViewController: UIViewController, ViewModelBased, StoryboardBased {

    @IBOutlet weak var contentView: UIView!

    var viewModel: WebViewViewModel!

    var addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)

    private var webView: WKWebView!

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        /// WebViewnoレイアウト設定
        setupWebView()
        /// ボタン配置
        setupAddButton()

        // WKNavigationDelegateに対応する非同期処理

        webView.rx
            .decidePolicyNavigationAction
            .subscribe { (event) in
                if let url = event.element?.action.request.url {
                    // 以下でWhiteList, URLスキームのハンドリングを行う
                    if url.absoluteString.contains("http") {
                        event.element?.handler(.allow)
                        return
                    }
                }
                event.element?.handler(.cancel)
            }
            .disposed(by: disposeBag)

        webView.rx
            .didStartProvisionalNavigation
            .subscribe { (event) in
                print(event)
            }
            .disposed(by: disposeBag)

        webView.rx
            .didFailProvisionalNavigation
            .subscribe {
                // stop loading
                // error handling
            }
            .disposed(by: disposeBag)

        webView.rx
            .didFailNavigation
            .subscribe {
                // stop loading
                // error handling
            }
            .disposed(by: disposeBag)

        webView.rx
            .didFinishNavigation
            .subscribe {
                // stop loading
            }
            .disposed(by: disposeBag)

    }

    // MARK: - Private methods

    private func setupAddButton() {
        navigationItem.setRightBarButton(addButton, animated: true)
    }

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

