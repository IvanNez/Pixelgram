//
//  SettingCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 18.06.2024.
//

import UIKit

class SettingCell: UITableViewCell {

    static let reuseId = "SettingCell"
    var completion: ( () -> () )?
    
    private lazy var cellView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .appMain
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
        $0.addSubview(self.cellStack)
        return $0
    }(UIView())
    
    private lazy var cellStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.addArrangedSubview(self.cellLabel)
        
        return $0
    }(UIStackView())
    
    private lazy var nextButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.widthAnchor.constraint(equalToConstant: 18).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(primaryAction: nextButtonAction))
    
    private lazy var nextButtonAction = UIAction { [weak self] _ in
        self?.completion?()
    }
    
    private lazy var cellLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        return $0
    }(UILabel())
    
    private lazy var locationSwitch: UISwitch = {
        $0.onTintColor = .black
        return $0
    }(UISwitch())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(cellView)
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            cellStack.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 15),
            cellStack.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -15),
            cellStack.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            cellStack.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20)
        ])
    }
    
    func cellSetup(cellType: SettingItems) {
        switch cellType {
        case .password, .delete:
            cellStack.addArrangedSubview(nextButton)
        case .location:
            cellStack.addArrangedSubview(locationSwitch)
            
        }
        
        cellLabel.text = cellType.rawValue
    }
}
