//
//  PasscodePresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 07.06.2024.
//

import UIKit

protocol PasscodePresenterProtocol: AnyObject {
    var passcode: [Int] { get set }
    var templatePasscode: [Int]? { get set }
    func enterPasscode(number: Int)
    func removeLastItemInPasscode()
    func setNewPasscode()
    func checkPasscode()
    func clearPasscode(state: PasscodeState)
    
    init (view: PasscodeViewProtocol, passcodeState: PasscodeState, keychainManager: KeychainManagerProtocol, sceneDelegate: SceneDelegateProtocol)
}

class PasscodePresenter: PasscodePresenterProtocol {
    
    var templatePasscode: [Int]?
    var passcode: [Int] = [] {
        didSet {
            if passcode.count  == 4 {
                switch passcodeState {
                case .inputPasscode:
                    self.checkPasscode()
                case .setNewPasscode:
                    self.setNewPasscode()
                default:
                    break
                }
            }
        }
    }
    weak var view: PasscodeViewProtocol?
    var passcodeState: PasscodeState
    var keychainManager: KeychainManagerProtocol
    var sceneDelegate: SceneDelegateProtocol
    
    required init(view: PasscodeViewProtocol, passcodeState: PasscodeState, keychainManager: KeychainManagerProtocol, sceneDelegate: SceneDelegateProtocol) {
        self.view = view
        self.passcodeState = passcodeState
        self.keychainManager = keychainManager
        self.sceneDelegate = sceneDelegate
        
        view.passcodeState(state: passcodeState)
    }
    
    
    func enterPasscode(number: Int) {
        if passcode.count < 4 {
            self.passcode.append(number)
            view?.enterCode(code: passcode)
        }
    }
    
    func removeLastItemInPasscode() {
        if !passcode.isEmpty {
            self.passcode.removeLast()
            view?.enterCode(code: passcode)
        }
    }
    
    func setNewPasscode() {
        if templatePasscode != nil {
            if passcode == templatePasscode! {
                let stringPasscode = passcode.map({String($0)}).joined()
                keychainManager.save(key: KeychainKeys.passcode.rawValue, value: stringPasscode)
                print("saved")
            } else {
                self.view?.passcodeState(state: .codeMissMatch)
            }
        } else {
            templatePasscode = passcode
            self.clearPasscode(state: .repeatPasscode)
        }
    }
    
    func checkPasscode() {
        let keychainPasscodeResult = keychainManager.load(key: KeychainKeys.passcode.rawValue)
        switch keychainPasscodeResult {
        case .success(let code):
            if self.passcode == code.digits {
                self.sceneDelegate.startMainScreen()
            } else {
                self.clearPasscode(state: .wrongPasscode)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func clearPasscode(state: PasscodeState) {
        self.passcode = []
        self.view?.enterCode(code: [])
        self.view?.passcodeState(state: state)
    }
        
}

enum PasscodeState: String {
    case inputPasscode, wrongPasscode, setNewPasscode, repeatPasscode, codeMissMatch
    
    func getPasscodeLabel() -> String {
        switch self {
        case .inputPasscode:
            return "Введите код"
        case .wrongPasscode:
            return "Неверный код"
        case .setNewPasscode:
            return "Установить код"
        case .repeatPasscode:
            return "Повторите код"
        case .codeMissMatch:
            return "Коды не сопадают"
        }
    }
}
