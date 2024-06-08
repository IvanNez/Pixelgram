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
    private let buttons: [ [Int] ] = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [0]]
    private lazy var passcodeTitle: UILabel = {
        .configure(view: $0) { label in
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textAlignment = .center
        }
    }(UILabel())
    
    private lazy var keyboardStack: UIStackView = {
        .configure(view: $0) { stack in
            stack.axis = .vertical
            stack.distribution = .equalSpacing
            stack.alignment = .center
        }
    }(UIStackView())
    
    private lazy var codeStack: UIStackView = {
        .configure(view: $0) { stack in
            stack.axis = .horizontal
            stack.distribution = .equalCentering
            stack.spacing = 20
        }
    }(UIStackView())
    
    private lazy var deleteBtn: UIButton = {
        .configure(view: $0) { btn in
            btn.widthAnchor.constraint(equalToConstant: 36).isActive = true
            btn.heightAnchor.constraint(equalToConstant: 36).isActive = true
            btn.setBackgroundImage(.deleteBtn, for: .normal)
        }
    }(UIButton(primaryAction: deleteCodeAction))
    
    lazy var enterCodeAction = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        
        self.passcodePresenter?.enterPasscode(number: sender.tag)
    }
    
    lazy var deleteCodeAction = UIAction { [weak self] sender in
        guard
            let self = self,
            let sender = sender.sender as? UIButton
        else { return }
        
        self.passcodePresenter?.removeLastItemInPasscode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .appMain
        setStacks()
        constraintsForStacks()
        constraintsForButtonDelete()
        constraintsForTitle()
        constraintsForCodeStack()
    }
}

//MARK: -- Setup layout
extension PasscodeView {
    private func setStacks() {
        [keyboardStack, passcodeTitle, codeStack, deleteBtn].forEach({view.addSubview($0)})
        
        buttons.forEach({
            let buttonLine = setHorizontalNumStack(range: $0)
            keyboardStack.addArrangedSubview(buttonLine)
        })
        (11...14).forEach {
            let view = getCodeView(tag: $0)
            codeStack.addArrangedSubview(view)
        }
    }
    private func constraintsForStacks() {
        NSLayoutConstraint.activate([
            keyboardStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            keyboardStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            keyboardStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 80)
        ])
    }
    private func constraintsForButtonDelete() {
        NSLayoutConstraint.activate([
            deleteBtn.rightAnchor.constraint(equalTo: keyboardStack.rightAnchor, constant: -21),
            deleteBtn.bottomAnchor.constraint(equalTo: keyboardStack.bottomAnchor, constant: -25)
        ])
    }
    private func constraintsForTitle() {
        NSLayoutConstraint.activate([
            passcodeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passcodeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passcodeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
        ])
    }
    private func constraintsForCodeStack() {
        NSLayoutConstraint.activate([
            codeStack.topAnchor.constraint(equalTo: passcodeTitle.bottomAnchor, constant: 50),
            codeStack.widthAnchor.constraint(equalToConstant: 140),
            codeStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: -- Setup stack
extension PasscodeView {
    private func getHorizontalNumStack() -> UIStackView {
        return {
            .configure(view: $0) { stack in
                stack.axis = .horizontal
                stack.spacing = 50
            }
        }(UIStackView())
    }
    private func setHorizontalNumStack(range: [Int]) -> UIStackView {
        let stack = getHorizontalNumStack()
        range.forEach({
            let numButton = UIButton(primaryAction: enterCodeAction)
            numButton.tag = $0
            numButton.setTitle("\($0)", for: .normal)
            numButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            numButton.setTitleColor(.white, for: .normal)
            numButton.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .light)
            stack.addArrangedSubview(numButton)
        })
        return stack
    }
    private func getCodeView(tag: Int) -> UIView {
        return {
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 20).isActive = true
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 2
            $0.tag = tag
            
            $0.layer.borderColor = UIColor.white.cgColor
            
            return $0
        }(UIView())
    }
}

// MARK: -- PasscodeViewProtocol
extension PasscodeView: PasscodeViewProtocol {
    func passcodeState(state: PasscodeState) {
        passcodeTitle.text = state.getPasscodeLabel()
    }
    
    func enterCode(code: [Int]) {
        let tag = code.count + 10
        
        (tag...14).forEach {
            view.viewWithTag($0)?.backgroundColor = .none
        }
        
        view.viewWithTag(tag)?.backgroundColor = .white
    }
}

#Preview() {
    PasscodeView()
}
