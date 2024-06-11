//
//  FavouriteView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

protocol FavouriteViewProtocol: AnyObject {
    func showPost()
}

class FavouriteView: UIViewController {
    
    var presenter: FavouriteViewPresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        
        let itemSize = ((view.bounds.width - 60) / 2) - 15
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 50, left: 30, bottom: 80, right: 30)
        
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.alwaysBounceVertical = true
        $0.backgroundColor = .appMain
        $0.register(FavouriteCell.self, forCellWithReuseIdentifier: FavouriteCell.reuseId)
        
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout()))

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
}

// MARK: -- Layer
private extension FavouriteView {
    func setup() {
        view.backgroundColor = .appMain
        view.addSubview(collectionView)
       
    }
    func setupNavBar() {
        title = "Избранное"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .appMain
        
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}

extension FavouriteView: FavouriteViewProtocol {
    func showPost() {
        self.collectionView.reloadData()
    }
}

extension FavouriteView: UICollectionViewDelegate {
    
}

extension FavouriteView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.post?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavouriteCell.reuseId, for: indexPath) as! FavouriteCell
        if let item = presenter.post?[indexPath.item] {
            cell.configureCell(item: item)
        }
        return cell
    }
}
