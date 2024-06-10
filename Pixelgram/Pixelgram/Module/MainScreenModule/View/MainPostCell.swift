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
        $0.addArrangedSubview(UIView())
        return $0
    }(UIStackView())
    
    lazy var addFavouriteButton: UIButton = {
        $0.frame = CGRect(x: bounds.width - 40, y: 25, width: 25, height: 25)
        $0.setBackgroundImage(.heart, for: .normal)
        $0.tintColor = .black
        return $0
    }(UIButton(primaryAction: nil))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentViewConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        tagCollectionView.removeFromSuperview()
        postDescriptionLabel.removeFromSuperview()
    }
}

// MARK: Setup layer
extension MainPostCell {
    func configureCell(item: PostItem) {
        tags = item.tag ?? []
        let tagCollection: TagCollectionViewProtocol = TagCollectionView(dataSource: self)
        tagCollectionView = tagCollection.getCollectionView()
        
        postImage.image = UIImage(named: item.photos.first!)
        photoCountLabel = getCellLabel(text: "\(item.photos.count) фото")
        commentCountLabel = getCellLabel(text: "\(item.comments?.count ?? 0) комментарий" )
        postDescriptionLabel = getCellLabel(text: "\(item.description ?? "")")
        
        [countLabelsStack, tagCollectionView, postDescriptionLabel].forEach({addSubview($0)})
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            countLabelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            countLabelsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            countLabelsStack.bottomAnchor.constraint(equalTo: tagCollectionView.topAnchor, constant: -8),
            
            tagCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 40),
            tagCollectionView.bottomAnchor.constraint(equalTo: postDescriptionLabel.topAnchor, constant: -10),
            
            postDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            postDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            postDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
    
    private func contentViewConfig() {
        [postImage, addFavouriteButton].forEach({addSubview($0)})
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
 

// MARK: -- UICollectionViewDataSource
extension MainPostCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.reuseId, for: indexPath) as! TagCollectionCell
        let tag = tags[indexPath.row]
        cell.cellConfigure(tagText: tag)
        
        return cell
    }
    
    
}
