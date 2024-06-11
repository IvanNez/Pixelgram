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
    lazy var seletedItem = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        self.selectedIndex = sender.tag
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedIndex = 2
    }
    
    private func setup() {
        setUpTabButtons()
    }
}

// MARK: Set layout
extension TabBarView {
    
    private func setUpTabButtons() {
        tabs.enumerated().forEach({element in
            let offsets: [Double] = [-100, 0, 100]
            let tabButton = createTabBarButton(icon: element.element, tag: element.offset, offseX: offsets[element.offset], isBigButton: element.offset == 1 ? true: false)
            view.addSubview(tabButton)
            
        })
    }
    
    private func createTabBarButton(icon: UIImage, tag: Int, offseX: Double, isBigButton: Bool = false) -> UIButton {
        return {
            let btnSize = isBigButton ? 60.0: 25.0
            $0.frame.size = CGSize(width: btnSize, height: btnSize)
            $0.tag = tag
            $0.setBackgroundImage(icon, for: .normal)
            $0.tintColor = .white
            $0.frame.origin = CGPoint(x: .zero, y: view.frame.height - (btnSize + (isBigButton ? 44: 62)))
            $0.center.x = view.center.x + offseX
            return $0
        }(UIButton(primaryAction: seletedItem))
    }
}

extension TabBarView: TabBarViewProtocol {
    func setControllers(controllers: [UIViewController]) {
        setViewControllers(controllers, animated: true)
    }
}
