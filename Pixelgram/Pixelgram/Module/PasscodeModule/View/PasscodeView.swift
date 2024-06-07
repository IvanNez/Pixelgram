//
//  PasscodeView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 07.06.2024.
//

import UIKit

protocol PasscodeViewProtocol: AnyObject {
    func passcodeState(state: PasscodeState)
    func enterCode(code: [Int])
}

class PasscodeView: UIViewController {

    var passcodePresenter: PasscodePresenterProtocol?
    lazy var passcodeTitle: UILabel = {
        .configure(view: $0) { label in
            label.textColor = .white
        }
    }(UILabel())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}


#Preview() {
    PasscodeView()
}



extension PasscodeView: PasscodeViewProtocol {
    func passcodeState(state: PasscodeState) {
        
    }
    
    func enterCode(code: [Int]) {
        print(code)
    }
}
