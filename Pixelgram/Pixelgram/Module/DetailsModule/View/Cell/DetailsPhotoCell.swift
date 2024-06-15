//
//  DetailsPhotoCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 15.06.2024.
//

import UIKit

class DetailsPhotoCell: UICollectionViewCell, CollectionViewCellProtocol {
    static var reuseId: String = "DetailsPhotoCell"
    private lazy var cellImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    private lazy var imageMenuButton: UIButton = {
        $0.setBackgroundImage(.dottetIcon, for: .normal)
        $0.frame = CGRect(x: cellImage.frame.width - 50, y: 30, width: 31, height: 6)
        return $0
    }(UIButton(primaryAction: nil))
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 30
        clipsToBounds = true
        addSubview(cellImage)
        cellImage.addSubview(imageMenuButton)
    }
    
    func configureCell(image: String) {
        self.cellImage.image = UIImage(named: image)
    }
}
