//
//  TabBarView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
    func setControllers(controllers: [UIViewController])
}

class TabBarView: UITabBarController {

    var presenter: TabBarViewPresenterProtocol!
    private let tabs: [UIImage] = [.home, .plus, .heart]
    private lazy var tabBarView: UIView = {
        return $0
    }(UIView(frame: CGRect(x: 0, y: view.frame.height - 100, width: view.frame.width, height: 60)))
    lazy var seletedItem = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        self.selectedIndex = sender.tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTabBar()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    
    @objc func hideTabBar(sender: Notification) {
        let isHide = sender.userInfo?["isHide"] as! Bool
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            if isHide {
                self.tabBarView.frame.origin.y = view.frame.height
            } else {
                self.tabBarView.frame.origin.y = view.frame.height - 100
            }
        }
    }
    
    @objc func goToMainView() {
        self.selectedIndex = 0
    }
}

// MARK: Set layout
private extension TabBarView {
    
    func setup() {
        setUpTabButtons()
        createNotification()
    }
    
    func createNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(hideTabBar), name: .hideTabBar, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToMainView), name: .GoToMain, object: nil)
    }
    
    func setUpTabButtons() {
        tabs.enumerated().forEach({element in
            let offsets: [Double] = [-100, 0, 100]
            let tabButton = createTabBarButton(icon: element.element, tag: element.offset, offsetX: offsets[element.offset], isBigButton: element.offset == 1 ? true: false)
            tabBarView.addSubview(tabButton)
            
        })
        view.addSubview(tabBarView)
    }
    
    func createTabBarButton(icon: UIImage, tag: Int, offsetX: Double, isBigButton: Bool = false) -> UIButton {
        return {
            let btnSize = isBigButton ? 60.0: 25.0
            let yOffset = isBigButton ? 0: 15
            $0.frame.size = CGSize(width: btnSize, height: btnSize)
            $0.tag = tag
            $0.setBackgroundImage(icon, for: .normal)
            $0.tintColor = .white
            $0.frame.origin = CGPoint(x: .zero, y: yOffset)
            $0.center.x = view.center.x + offsetX
            return $0
        }(UIButton(primaryAction: seletedItem))
    }
}

extension TabBarView: TabBarViewProtocol {
    
    private func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let cameraScreen = Builder.createCameraScreenController()
        let favouriteScreen = Builder.createFavouriteScreenController()
        self.setControllers(controllers: [mainScreen, cameraScreen, favouriteScreen])
    }
    
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
}
