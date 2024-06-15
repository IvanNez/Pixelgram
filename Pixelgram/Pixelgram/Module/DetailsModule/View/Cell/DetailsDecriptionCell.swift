//
//  DetailsDecriptionCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 15.06.2024.
//

import UIKit

class DetailsDecriptionCell: UICollectionViewCell, CollectionViewCellProtocol {
    static var reuseId: String = "DetailsDecriptionCell"
    private lazy var dateTextLabel = UILabel()
    private lazy var descriptionTextLabel = UILabel()
    private lazy var cellStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .leading
        $0.axis = .vertical
        $0.spacing = 7
        return $0
    }(UIStackView())
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(cellStack)
        backgroundColor = .appBlack
        layer.cornerRadius = 30
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            cellStack.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            cellStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            cellStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            cellStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
        ])
    }
    
    private func createCellLabel(text: String, weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: weight)
        label.textColor = .white
        return label
    }
    
    func configureCell(date: Date?, text: String) {
        if date != nil {
            dateTextLabel = createCellLabel(text: date?.formattDate(formatType: .onlyDate) ?? "", weight: .bold)
            cellStack.addArrangedSubview(dateTextLabel)
        }
        descriptionTextLabel = createCellLabel(text: text, weight: .regular)
        cellStack.addArrangedSubview(descriptionTextLabel)
    }
}
