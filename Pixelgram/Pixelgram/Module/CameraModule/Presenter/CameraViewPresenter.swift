//
//  CameraViewPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 16.06.2024.
//

import UIKit

protocol CameraViewPresenterProtocol: AnyObject {
    var photos: [UIImage] { get set }
    var closeViewAction: UIAction? { get set }
    var switchCamera: UIAction? { get set }
    var cameraService: CameraServiceProtocol { get set }
    init(view: CameraViewProtocol, cameraService: CameraServiceProtocol)
    func deletePhoto(index: Int)
}

class CameraViewPresenter: CameraViewPresenterProtocol {

    var cameraService: CameraServiceProtocol
    private weak var view: CameraViewProtocol?
    var photos: [UIImage] = []
    
    lazy var closeViewAction: UIAction? = UIAction { [weak self] _ in
        self?.closeView()
        
    }
    lazy var switchCamera: UIAction? = UIAction { [weak self] _ in
        self?.cameraService.switchCamera()
    }
    
    
    required init(view: any CameraViewProtocol, cameraService: CameraServiceProtocol) {
        self.view = view
        self.cameraService = cameraService
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeView), name: .dissmisCameraView, object: nil)
    }
    
    func deletePhoto(index: Int) {
        photos.remove(at: index)
    }
    
    @objc
    func closeView() {
        NotificationCenter.default.post(name: .GoToMain, object: nil)
        self.cameraService.stopSession()
    }
}
