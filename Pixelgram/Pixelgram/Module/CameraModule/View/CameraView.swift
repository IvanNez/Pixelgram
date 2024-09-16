//
//  CameraView.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import UIKit
import AVFoundation

protocol CameraViewProtocol: AnyObject {
    
}

protocol CameraViewDelegate {
    func deletePhoto(index: Int)
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
        $0.layer.opacity = 0.6
        $0.isEnabled = false
        $0.layer.cornerRadius = 17.5
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.frame.size = CGSize(width: 100, height: 35)
        $0.frame.origin = CGPoint(x: shotButton.frame.origin.x + 90, y: shotButton.frame.origin.y + 12.5)
        return $0
    }(UIButton(primaryAction: nextButtonAction))
    private lazy var nextButtonAction = UIAction  { [weak self] _ in
        guard let self else { return }
        if let addPostVC = Builder.createAddPostViewController(photos: self.presenter.photos) as? AddPostView {
            addPostVC.delegate = self
            navigationController?.pushViewController(addPostVC, animated: true)
        }
       
    }
    
    private lazy var shotAction = UIAction { [weak self] _ in
        guard let self else { return }
        let photoSettings = AVCapturePhotoSettings()
        self.presenter.cameraService.output.capturePhoto(with: photoSettings, delegate: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAllPhoto), name: .dissmisCameraView, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.cameraService.setupCaptureSession()
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.post(name: .hideTabBar, object: nil, userInfo: ["isHide": true])
    }
    
}

// MARK: -- Setup layer
private extension CameraView {
    func setup() {
        checkPermisions()
        setupPreviewLayer()
        view.backgroundColor = .gray
        view.addSubview(shotsCollectionView)
        view.addSubview(closeButton)
        view.addSubview(shotButton)
        view.addSubview(switchCameraButton)
        view.addSubview(nextButton)
    }
    
    func checkPermisions() {
        let cameraStatusAuth = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraStatusAuth {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { auth in
                if !auth {
                    abort()
                }
            }
        case .restricted, .denied:
            abort()
        case .authorized:
            return
        default:
            fatalError()
        }
    }
    
    func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: presenter.cameraService.captureSession)
        
        previewLayer.frame = view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
    }
    
    func getImageView(image: UIImage) -> UIImageView {
        let imageView = UIImageView()
        imageView.frame.size = CGSize(width: 60, height: 60)
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }
}

// MARK: -- CameraViewProtocol
extension CameraView: CameraViewProtocol {
    
}


// MARK: -- AVCapturePhotoCaptureDelegate
extension CameraView: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard error == nil else {
            print(error!.localizedDescription)
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        if let image = UIImage(data: imageData) {
            presenter.photos.append(image)
            nextButton.layer.opacity = 1
            nextButton.isEnabled = true
            self.shotsCollectionView.reloadData()
        }
            
    }
    

}

// MARK: -- UICollectionViewDataSource
extension CameraView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shotCell", for: indexPath)
        
        let photo = presenter.photos[indexPath.item]
        let imageView = self.getImageView(image: photo)
        cell.addSubview(imageView)
        return cell
    }
    
    
}


// MARK: -- CameraViewDelegate
extension CameraView: CameraViewDelegate {
    
    @objc
    func deleteAllPhoto() {
        presenter.photos.removeAll()
        nextButton.layer.opacity = 0.6
        nextButton.isEnabled = false
        shotsCollectionView.reloadData()
    }
    
    func deletePhoto(index: Int) {
        presenter.deletePhoto(index: index)
        if presenter.photos.count == 0 {
            nextButton.layer.opacity = 0.6
            nextButton.isEnabled = false
        }
        shotsCollectionView.reloadData()
    }
}
