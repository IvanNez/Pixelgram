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
    init(view: CameraViewProtocol)
}

class CameraViewPresenter: CameraViewPresenterProtocol {
    
    private weak var view: CameraViewProtocol?
    var photos: [UIImage] = []
    var closeViewAction: UIAction? = UIAction { _ in
        NotificationCenter.default.post(name: .GoToMain, object: nil)
    }
    var switchCamera: UIAction? = UIAction { _ in
        
    }
    
    
    required init(view: any CameraViewProtocol) {
        self.view = view
    }
    
    
}
