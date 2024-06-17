//
//  AddPostView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 17.06.2024.
//

import UIKit

protocol AddPostViewProtocol: AnyObject {
    
}

class AddPostView: UIViewController {

    var presenter: AddPostPresenterProtocol!
     
    private lazy var backAction = UIAction { [ weak self ] _ in
        self?.navigationController?.popViewController(animated: true)
    }
    private var menuViewHeight = UIApplication.topSafeArea + 50
    private lazy var topMenuView: UIView = {
        $0.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: menuViewHeight)
        $0.backgroundColor = .appMain
        return $0
    }(UIView())
    private lazy var navigationHeader: NavigationHeader = {
        NavigationHeader(backAction: self.backAction, date: Date())
    }()
    private lazy var collectionView: UICollectionView = {
        $0.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 100, right: 0)
        $0.backgroundColor = .none
        $0.dataSource = self
        $0.showsVerticalScrollIndicator = false
        $0.register(AddPostPhotoCell.self, forCellWithReuseIdentifier: AddPostPhotoCell.reuseId)
        $0.register(AddPostTagCell.self, forCellWithReuseIdentifier: AddPostTagCell.reuseId)
        $0.register(AddPostFieldCell.self, forCellWithReuseIdentifier: AddPostFieldCell.reuseId)
        return $0
    }(UICollectionView(frame: view.bounds, collectionViewLayout: getCompositionLayout()))
    
    private lazy var saveButton: UIButton = {
        $0.backgroundColor = .appBlack
        $0.setTitle("Сохранить", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.gray, for: .highlighted)
        $0.layer.cornerRadius = 27.5
        return $0
    }(UIButton(frame: CGRect(x: 30, y: view.bounds.height - 98, width: view.bounds.width - 60, height: 55), primaryAction: saveButtonAction))
    private lazy var saveButtonAction = UIAction { _ in
        print("SAVE")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: -- Set layer
private extension AddPostView {
    func setup() {
        view.backgroundColor = .appMain
        view.addSubview(collectionView)
        view.addSubview(topMenuView)
        view.addSubview(saveButton)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupHeader()
    }
    func setupHeader() {
        let header = navigationHeader.getNavigationHeader(type: .addPostView)
        header.frame .origin.y = UIApplication.topSafeArea
        view.addSubview(header)
    }
    
    @objc func keyboardChange(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardViewFrame = view.convert(keyboardValue.cgRectValue, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            collectionView.contentInset.bottom = 100
        } else {
            collectionView.contentInset.bottom = keyboardViewFrame.height
        }
        
    }
    @objc func  endEditing() {
        view.endEditing(true)
    }
}

// MARK: -- CompositionLayout
private extension AddPostView {
    func getCompositionLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch section {
            case 0:
                return self?.createPhotoSection()
            case 1:
                return self?.createTagSection()
            default:
                return self?.createFormSection()
            }
        }
    }
    
    func createPhotoSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(260))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    func createTagSection() -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(110), heightDimension: .estimated(10))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [.init(layoutSize: groupSize)])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 50, bottom: 30, trailing: 10)
        
        return section
    }
    func createFormSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(185))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 30)
      
        return section
    }
    
}

// MARK: -- AddPostViewProtocol
extension AddPostView: AddPostViewProtocol {
    
}

// MARK: -- UICollectionViewDataSource
extension AddPostView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return presenter.photos.count
        case 1:
            return presenter.tags.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostPhotoCell.reuseId, for: indexPath) as! AddPostPhotoCell
            let image = presenter.photos[indexPath.row]
            cell.setCellImage(image: image)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostTagCell.reuseId, for: indexPath) as! AddPostTagCell
            let tag = presenter.tags[indexPath.row]
            cell.setTagText(tagText: tag)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPostFieldCell.reuseId, for: indexPath) as! AddPostFieldCell
            
            return cell
        }
    }
    
    
}
