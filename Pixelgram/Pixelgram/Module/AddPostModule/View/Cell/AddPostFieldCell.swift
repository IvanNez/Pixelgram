//
//  AddPostFieldCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 17.06.2024.
//

import UIKit

class AddPostFieldCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    static var reuseId: String = "AddPostFieldCell"
    
    var delegate: AddPostViewDelegate?
    
    private lazy var tagField: UITextField = {
        $0.backgroundColor = .appBlack
        $0.attributedPlaceholder = NSAttributedString(string: "Добавить тег", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 1))
        $0.leftViewMode = .always
        $0.layer.cornerRadius = 24
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
        return $0
    }(UITextField(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 48), primaryAction: tagFieldAction))

    
    private lazy var tagFieldAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        delegate?.addTag(tag: tagField.text)
        tagField.text = ""
    }

    private lazy var placeholder: UILabel = {
        $0.text = "Описание"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .white
        $0.layer.opacity = 0.4
        return $0
    }(UILabel(frame: CGRect(x: 24, y: 19, width: 100, height: 20)))
    
    private lazy var textView: UITextView = {
        $0.backgroundColor = .appBlack
        $0.delegate = self
        $0.layer.cornerRadius = 30
        $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.addSubview(placeholder)
        return $0
    }(UITextView(frame: CGRect(x: 0, y: 68, width: bounds.width, height: 115)))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(tagField)
        addSubview(textView)
    }
    
}

extension AddPostFieldCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 0 {
            placeholder.isHidden = false
        } else {
            placeholder.isHidden = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        delegate?.addDescription(text: text)
    }
}

