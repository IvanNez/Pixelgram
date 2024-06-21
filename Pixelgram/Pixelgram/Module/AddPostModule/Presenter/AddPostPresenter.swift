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
    var postDescription: String? { get set }
    init(view: AddPostViewProtocol, photos: [UIImage])
    func savePost()
}

class AddPostPresenter: AddPostPresenterProtocol {
 
    private weak var view: AddPostViewProtocol?
    private let coreManager = CoreManager.shared
    var photos: [UIImage]
    var tags: [String] = []
    var postDescription: String?
    
    required init(view: AddPostViewProtocol, photos: [UIImage]) {
        self.view = view
        self.photos = photos
    }
    
    func savePost() {
        
        // file manager
        let id = UUID().uuidString
        
        let post: PostItem = {
            $0.id = id
            $0.photos = ["img1", "img2"]
            $0.comments = []
            $0.tags = self.tags
            $0.date = Date()
            $0.isFavourite = false
            $0.postDescription = self.postDescription
            return $0
        }(PostItem(context: coreManager.persistentContainer.viewContext))

        coreManager.savePost(post: post)
    }
}
