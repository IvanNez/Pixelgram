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
    func savePost()
}

class AddPostPresenter: AddPostPresenterProtocol {
    
    private weak var view: AddPostViewProtocol?
    var storageManager = StorageManager.shared
    private let coreManager = CoreManager.shared
    
    var photos: [UIImage]
    var tags: [String] = []
    var postDescription: String?
    
    
    required init(view: AddPostViewProtocol, photos: [UIImage]) {
        self.view = view
        self.photos = photos
    }
    
    func savePost() {
        var photosData: [Data?] = []
        let id = UUID().uuidString
        
        photos.forEach {
            let imageData = $0.jpegData(compressionQuality: 1)
            photosData.append(imageData)
        }
        
        let photos = storageManager.savePhotos(postID: id, photos: photosData)
     
        let post: PostItem = {
            $0.id = id
            $0.photos = photos
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
