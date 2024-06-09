//
//  TabBarPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
    func buildTabBar()
}

class TabBarViewPresenter {
    
    weak var view: TabBarViewProtocol?

    required init(view: any TabBarViewProtocol) {
        self.view = view
        self.buildTabBar()
    }
}

extension TabBarViewPresenter: TabBarViewPresenterProtocol {

    func buildTabBar() {
        let mainScreen = Builder.createMainScreenController()
        let favouriteScreen = Builder.createFavouriteScreenController()
        let cameraScreen = Builder.createCameraScreenController()
        self.view?.setControllers(controllers: [mainScreen, favouriteScreen, cameraScreen])
    }
}
