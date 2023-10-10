//
//  Created by 유태훈 on 2023/10/05.
//

import UIKit
import WebKit

open class THLicensesDetailViewController: UIViewController {
    private let item: THLicensesKeyEntity
    private var license: THLicensesEntity?
    private var store = THLicensesStore()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        textView.isEditable = false
        textView.alwaysBounceVertical = true
        textView.dataDetectorTypes = .link
        return textView
    }()
    
    private lazy var webView: WKWebView = {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let contentController = WKUserContentController()
        contentController.addUserScript(script)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        let webView = WKWebView(frame: .zero, configuration: config)
        if #available(iOS 14.0, *) {
            webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        } else {
            webView.configuration.preferences.javaScriptEnabled = true
        }
        
        webView.backgroundColor = .clear
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()

    public init(item: THLicensesKeyEntity, license: THLicensesEntity?) {
        self.item = item
        self.license = license
        super.init(nibName: nil, bundle: nil)
        self.title = self.item.name
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        if let text = self.item.licenseText {
            self.textView.text = text
            return
        }
        
        guard let license = self.license else { return }
        
        switch license.key {
        case .agpl3, .apache2, .bsd2clause, .bsd3clause, .bsl1, .cc01, .epl2, .gpl2, .gpl3, .lgpl2, .mit, .mpl2, .unlicense:
            self.fetchLicense(license.url)
        case .buycoffee, .unknown:
            guard let str = self.item.url, let url = URL(string: str) else { return }
            let request = URLRequest(url: url)
            self.setupWebview(request)
            break
        }
    }
    
    private func setupWebview(_ url: URLRequest) {
        self.webView.frame = self.view.bounds
        self.view.addSubview(self.webView)
        self.webView.load(url)
    }
    
    private func fetchLicense(_ license: String) {
        guard let url = URL(string: license) else { return }
        self.textView.frame = self.view.bounds
        self.textView.contentOffset = .zero
        self.view.addSubview(self.textView)
        
        store.fetch(url) { result in
            switch result {
            case .success(let success):
                guard let body = success.body else { return }
                let replaceText = body
                                    .replacingOccurrences(of: "[fullname]", with: self.item.fullName)
                                    .replacingOccurrences(of: "[year]", with: self.item.yearToString)
                DispatchQueue.main.async {
                    self.textView.text = replaceText
                }
            case .failure(let failure):
                let alert = UIAlertController(title: "알림", message: "라이선스를 확인할 수 없습니다. (에러메시지: \(failure.message))", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel) {_ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
    }
}

extension THLicensesDetailViewController: WKUIDelegate {}

extension THLicensesDetailViewController: WKNavigationDelegate {}
