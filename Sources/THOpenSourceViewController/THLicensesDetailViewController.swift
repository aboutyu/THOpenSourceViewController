//
//  Created by 유태훈 on 2023/10/05.
//

import UIKit

open class THLicensesDetailViewController: UIViewController {
    private let item: THLicensesKeyEntity
    private var license: THLicensesEntity?
    private var store = THLicensesStore()

    private var textView: UITextView = {
        let textView = UITextView()
        textView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        textView.isEditable = false
        textView.alwaysBounceVertical = true
        textView.dataDetectorTypes = .link
        return textView
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
        self.textView.frame = self.view.bounds
        self.textView.contentOffset = .zero
        self.view.addSubview(self.textView)
        
        if let text = self.item.licenseText {
            self.textView.text = text
            return
        }
        
        guard let license = license?.url, let url = URL(string: license) else { return }
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


