//
//  MainPostCell.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

class MainPostCell: UICollectionViewCell {
    static let reuseId = "MainPostCell"
    private var tags: [String] = []
    private var tagCollectionView: UICollectionView!
    private var photoCountLabel = UILabel()
    private var commentCountLabel = UILabel()
    private var postDescriptionLabel = UILabel()
    
    lazy var postImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView(frame: bounds))
    
    lazy var countLabelsStack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 20
        $0.addArrangedSubview(photoCountLabel)
        $0.addArrangedSubview(commentCountLabel)
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Setup layer
extension MainPostCell {
    func configureCell(item: PostItem) {
        postImage.image = UIImage(named: item.photos.first!)
        photoCountLabel = getCellLabel(text: "\(item.photos.count) фото")
        commentCountLabel = getCellLabel(text: "\(item.comments?.count ?? 0) комментарий" )
        postDescriptionLabel = getCellLabel(text: "\(item.description ?? "")")
        
        addSubview(countLabelsStack)
        
    }
    
    private func contentViewConfig() {
        addSubview(postImage)
        layer.cornerRadius = 30
        clipsToBounds = true
        setViewGradient(frame: bounds, startPoint: CGPoint(x: 0.5, y: 1), endPoint: CGPoint(x: 0.5, y: 0.5), colors: [.black, .clear], location: [0, 1])
        
    }
    
    private func getCellLabel(text: String) -> UILabel {
        return {
            .configure(view: $0) { label in
                label.numberOfLines = 0
                label.font = UIFont.systemFont(ofSize: 14)
                label.text = text
                label.textColor = .white
            }
        }(UILabel())
    }
}
 
