//
//  Builder.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 07.06.2024.
//

import UIKit

protocol BuilderProtocol {
    static func getPasscodeController() -> UIViewController
}

class Builder: BuilderProtocol {
    static func getPasscodeController() -> UIViewController {
        let passcodeView = PasscodeView()
        let presenter = PasscodePresenter(view: passcodeView, passcodeState: .inputPasscode)
        passcodeView.passcodePresenter = presenter
        
        return passcodeView
        
        
    }
}
