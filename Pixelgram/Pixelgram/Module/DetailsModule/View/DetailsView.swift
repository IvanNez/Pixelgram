//
//  DetailsView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 12.06.2024.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    
}

class DetailsView: UIViewController {
    
    var presenter: DetailsViewPresenterProtocol!
    private var menuViewHeight = UIApplication.topSafeArea + 50
    private lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = .appMain
        return $0
    }(UIView())
    private lazy var backAction = UIAction { [weak self] _ in
        self?.navigationController?.popViewController(animated: true)
    }
    private lazy var menuAction = UIAction{ [weak self] _ in
        print("menu")
    }
    private lazy var navigationHeader: NavigationHeader = {
        NavigationHeader(backAction: backAction, menuAction: menuAction ,date: presenter.item.date)
    }()
    private lazy var collectionView: UICollectionView = {
        $0.backgroundColor = .none
        $0.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 100, right: 0)
        $0.dataSource = self
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        $0.register(TagCollectionCell.self, forCellWithReuseIdentifier: TagCollectionCell.reuseId)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: getCompositionLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: -- Setup layer
private extension DetailsView {
    func setup() {
        view.backgroundColor = .appMain
        view.addSubview(collectionView)
        view.addSubview(topMenuView)
        setupPageHeader()
    }
    
    func setupPageHeader() {
        let headerView = navigationHeader.getNavigationHeader(type: .back)
        headerView.frame.origin.y = UIApplication.topSafeArea + 20
        view.addSubview(headerView)
    }
}

// MARK: -- Setup compositionla layout
private extension DetailsView {
    func getCompositionLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch section {
            case 0:
                return self?.createPhotoSection()
            case 1:
                return self?.createTagSection()
            case 2, 3:
                return self?.createDescriptionSection()
            default:
                return self?.createPhotoSection()
            }
            
        }
    }
    
    private func createPhotoSection() -> NSCollectionLayoutSection {
        // item (size)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        // group(size) + item
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // section + group
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 30, trailing: 30)
        return section
    }
    private func createTagSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(110), heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [.init(layoutSize: groupSize)])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10), top: nil, trailing: .fixed(0), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 40, bottom: 20, trailing: 20)
        return section
    }
    private func createDescriptionSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [.init(layoutSize: groupSize)])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: nil, bottom: .fixed(10))
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30)
        return section
    }
}

// MARK: -- DetailsViewProtocol
extension DetailsView: DetailsViewProtocol {
    
}
// MARK: -- UICollectionViewDataSource
extension DetailsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.item.photos.count + 5
        case 1:
            return presenter.item.tag?.count ?? 0
        case 2: //, 4, 5:
            return 1
        case 3:
            return 3 /*presenter.item.comments?.count ?? 0*/
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = presenter.item
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionCell.reuseId, for: indexPath) as! TagCollectionCell
            cell.cellConfigure(tagText: item.tag?[indexPath.row] ?? "")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    
}
