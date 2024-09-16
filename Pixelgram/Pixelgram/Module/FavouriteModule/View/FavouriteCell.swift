//
//  FavouriteCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 11.06.2024.
//

import UIKit

class FavouriteCell: UICollectionViewCell, CollectionViewCellProtocol {
    static let reuseId = "FavouriteCell"
    
    var completion: (() -> ())?
    private lazy var postImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    
    private lazy var removeInFavouriteButton: UIButton = {
        $0.frame = CGRect(x: bounds.width - 43, y: 21, width: 25, height: 25)
        $0.setBackgroundImage(.heartBlack, for: .normal)
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        self?.completion?()
    })))
    
    private lazy var dateView: UIView = {
        $0.frame = CGRect(x: 10, y: bounds.height - 47, width: bounds.width - 20, height: 27)
        $0.backgroundColor = UIColor(white: 1, alpha: 0.4)
        $0.layer.cornerRadius = 14
        $0.addSubview(dateLabel)
        return $0
    }(UIView())
    
    private lazy var dateLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .white
        $0.frame = CGRect(x: 0, y: 0, width: bounds.width - 20, height: 27)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        [postImage, removeInFavouriteButton, dateView].forEach({addSubview($0)})
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    func configureCell(item: PostItem) {
        postImage.image = .getOneImage(folderID: item.id ?? "", photo: item.photos?.first ?? "")
        dateLabel.text = item.date?.formattDate()
    }
    
}
