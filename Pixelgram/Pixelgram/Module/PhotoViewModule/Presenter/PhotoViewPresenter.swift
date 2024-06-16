//
//  PhotoViewPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 16.06.2024.
//

import UIKit

protocol PhotoViewPresenterProtocol: AnyObject {
    var image: UIImage? { get set }
    init(view: PhotoViewProtocol, image: UIImage?)
    
}

class PhotoViewPresenter: PhotoViewPresenterProtocol {
    
    var image: UIImage?
    private weak var view: PhotoViewProtocol?
    
    required init(view: any PhotoViewProtocol, image: UIImage?) {
        self.image = image
        self.view = view
    }
    
    
}
