//
//  SettingsViewPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 18.06.2024.
//

import Foundation

protocol SettingsViewPresenterProtocol: AnyObject {
    init(view: SettingsViewProtocol)
}

class SettingsViewPresenter: SettingsViewPresenterProtocol {
    
    private weak var view: SettingsViewProtocol?
    
    required init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    
}


