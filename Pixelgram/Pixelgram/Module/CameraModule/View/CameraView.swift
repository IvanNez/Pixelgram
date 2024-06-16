//
//  CameraView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit

protocol CameraViewProtocol: AnyObject {
    
}

class CameraView: UIViewController {

    var presenter: CameraViewPresenterProtocol!
    
    private lazy var shotsCollectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 60)
        
        $0.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "shotCell")
        $0.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        return $0
    }(UICollectionView(frame: CGRect(x: 0, y: 60, width: view.frame.width - 110, height: 60), collectionViewLayout: UICollectionViewFlowLayout()))
    private lazy var closeButton: UIButton = {
        $0.setBackgroundImage(.closeIcon, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: view.frame.width - 60, y: 60, width: 25, height: 25), primaryAction: presenter.closeViewAction))
    private lazy var shotButton: UIButton = {
        $0.setBackgroundImage(.shotBtn, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: view.center.x - 30, y: view.frame.height - 110 , width: 60, height: 60), primaryAction: shotAction))
    private lazy var switchCameraButton: UIButton = {
        $0.setBackgroundImage(.switchCamera, for: .normal)
        return $0
    }(UIButton(frame: CGRect(x: shotButton.frame.origin.x - 60, y: shotButton.frame.origin.y + 17.5, width: 25, height: 25), primaryAction: presenter.switchCamera))
    private lazy var nextButton: UIButton = {
        $0.setTitle("Далее", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 17.5
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.frame.size = CGSize(width: 100, height: 35)
        $0.frame.origin = CGPoint(x: shotButton.frame.origin.x + 90, y: shotButton.frame.origin.y + 12.5)
        return $0
    }(UIButton())
    
    private lazy var shotAction = UIAction { _ in
        print(#function)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.post(name: .hideTabBar, object: nil, userInfo: ["isHide": true])
    }
    
}

// MARK: -- Setup layer
private extension CameraView {
    func setup() {
        view.backgroundColor = .gray
        view.addSubview(shotsCollectionView)
        view.addSubview(closeButton)
        view.addSubview(shotButton)
        view.addSubview(switchCameraButton)
        view.addSubview(nextButton)
    }
}

// MARK: -- CameraViewProtocol
extension CameraView: CameraViewProtocol {
    
}

// MARK: -- UICollectionViewDataSource
extension CameraView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shotCell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    
}
