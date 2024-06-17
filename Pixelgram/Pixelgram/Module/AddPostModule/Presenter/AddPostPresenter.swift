//
//  AddPostPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 17.06.2024.
//

import UIKit

protocol AddPostPresenterProtocol: AnyObject {
    var photos: [UIImage] { get set }
    var tags: [String] { get set }
    init(view: AddPostViewProtocol, photos: [UIImage])
}

class AddPostPresenter: AddPostPresenterProtocol {
    
    private weak var view: AddPostViewProtocol?
    var photos: [UIImage]
    var tags: [String] = ["Дерево", "Дом", "milk", "car", "house"]
    
    required init(view: AddPostViewProtocol, photos: [UIImage]) {
        self.view = view
        self.photos = photos
    }
    
    
}
