//
//  DetailsView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 12.06.2024.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsView: UIViewController {
    
    var presenter: DetailsViewPresenterProtocol!
    private var menuViewHeight = UIApplication.topSafeArea + 50
    private lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = .appMain
        return $0
    }(UIView())
    private lazy var backAction = UIAction { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
    }
    private lazy var menuAction = UIAction{ [weak self] _ in
            print("menu")
    }
    private lazy var navigationHeader: NavigationHeader = {
        NavigationHeader(backAction: backAction, menuAction: menuAction ,date: presenter.item.date)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: -- Setup layer
private extension DetailsView {
    func setup() {
        view.backgroundColor = .appMain
        view.addSubview(topMenuView)
        setupPageHeader()
    }
    
    func setupPageHeader() {
        let headerView = navigationHeader.getNavigationHeader(type: .back)
        headerView.frame.origin.y = UIApplication.topSafeArea + 20
        view.addSubview(headerView)
    }
}

// MARK: -- DetailsViewProtocol
extension DetailsView: DetailsViewProtocol {
    
}
