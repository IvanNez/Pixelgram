//
//  TabBarPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

protocol TabBarViewPresenterProtocol: AnyObject {
    init(view: TabBarViewProtocol)
}

class TabBarViewPresenter: TabBarViewPresenterProtocol {
    
    weak var view: TabBarViewProtocol?

    required init(view: any TabBarViewProtocol) {
        self.view = view
    }
}

