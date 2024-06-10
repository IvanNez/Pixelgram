//
//  TagCollectionView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 10.06.2024.
//

import UIKit

protocol TagCollectionViewProtocol: AnyObject {
    var dataSource: UICollectionViewDataSource { get set }
    init (dataSource: UICollectionViewDataSource)
    func getCollectionView() -> UICollectionView
    var isEditing: Bool { get set }
}

class TagCollectionView: TagCollectionViewProtocol {
    
    var dataSource: any UICollectionViewDataSource
    var isEditing: Bool = false
    
    required init(dataSource: any UICollectionViewDataSource) {
        self.dataSource = dataSource
    }
    
    func getCollectionView() -> UICollectionView {
        return {
            .configure(view: $0) { [weak self] collection in
                guard let self else { return }
                let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
                layout.scrollDirection = .horizontal
                layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                
                collection.alwaysBounceHorizontal = false
                collection.showsHorizontalScrollIndicator = false
                collection.dataSource = self.dataSource
                collection.backgroundColor = .clear
                collection.register(TagCollectionCell.self, forCellWithReuseIdentifier: "TagCollectionCell")
            }
        }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    }
    
    
}
