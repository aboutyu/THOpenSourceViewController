//
//  Created by 유태훈 on 2023/10/05.
//

import UIKit

open class THOpenSourceViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let store = THLicensesStore()
    private var license: [THLicensesEntity] = []
    
    private var navigationTitle: String = "Open Source Licenses"
    private var items: [THLicensesKeyEntity] = []
    
    init(_ items: [THLicensesKeyEntity], title: String? = nil) {
        self.items = items.sorted { $0.name < $1.name }
        self.navigationTitle = title ?? self.navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setLicenses()
        setupUI()
        setupAttribute()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = navigationTitle
    }
    
    private func setupUI() {
        [tableView].forEach { view.addSubview($0) }
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupAttribute() {
        tableView.separatorStyle = .singleLine
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setLicenses() {
        store.fetchLicense { result in
            switch result {
            case .success(let data):
                self.license = data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                let alert = UIAlertController(title: "알림", message: "라이선스를 확인할 수 없습니다. (에러메시지: \(error.message))", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .cancel) {_ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(ok)
                self.present(alert, animated: true)
                break
            }
        }
    }
}

extension THOpenSourceViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = items[indexPath.row]
        let entity: THLicensesEntity? = {
            let entity = license.firstIndex(where: {$0.key == item.license})
            if let index = entity, index < license.count {
                return license[index]
            }
            return nil
        }()
        
        let detailViewController = THLicensesDetailViewController(item: item, license: entity)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

