//
//  SettingsView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 18.06.2024.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    var tableView: UITableView { get set }
    
}

class SettingsView: UIViewController {
    
    var presenter: SettingsViewPresenterProtocol!
    
    lazy var tableView: UITableView = {
        $0.dataSource = self
        $0.backgroundColor = .appBlack
        $0.separatorStyle = .none
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseId)
        return $0
    }(UITableView(frame: view.bounds, style: .insetGrouped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
}

private extension SettingsView {
    func setup() {
        view.backgroundColor = .appBlack
        title = "Настройки"
        
        view.addSubview(tableView)
    }
    
    func setupNavBar() {
        navigationController?.navigationBar.barTintColor = .appMain
        navigationController?.navigationBar.barTintColor = .appBlack
        
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}


// MARK: -- SettingsViewProtocol
extension SettingsView: SettingsViewProtocol {
     
    
    
}

// MARK: -- UITableViewDataSource
extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingItems.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseId, for: indexPath) as! SettingCell
        let cellItem = SettingItems.allCases[indexPath.row]
        cell.cellSetup(cellType: cellItem)
        
        cell.completion = {
            if indexPath.row == 0 {
                let passcodeVC = Builder.getPasscodeController(passcodeState: .setNewPasscode, sceneDelegate: nil, isSetting: true)
                self.present(passcodeVC, animated: true)
            }
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    
}
