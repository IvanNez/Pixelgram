//
//  AddPostTagCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 17.06.2024.
//

import UIKit

class AddPostTagCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    static var reuseId: String = "AddPostTagCell"
    
    private lazy var tagView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(white: 1, alpha: 0.2)
        $0.layer.cornerRadius = 14
        $0.addSubview(tagStack)
        return $0
    }(UIView())
    private lazy var tagStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 20
        $0.addArrangedSubview(tagLabel)
        $0.addArrangedSubview(removeButton)
        return $0
    }(UIStackView())
    private lazy var tagLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        return $0
    }(UILabel())
    private lazy var removeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(.closeIcon, for: .normal)
        $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 15).isActive = true

        return $0
    }(UIButton(primaryAction: removeAction))
    
    private lazy var removeAction = UIAction { _ in
        print("remove")
        
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(tagView)
        setConstraints()
    }
    
    func setTagText(tagText: String) {
        self.tagLabel.text = tagText
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: topAnchor),
            tagView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tagStack.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 7),
            tagStack.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: -7),
            tagStack.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 20),
            tagStack.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: -20)
        ])
    }
    
}
