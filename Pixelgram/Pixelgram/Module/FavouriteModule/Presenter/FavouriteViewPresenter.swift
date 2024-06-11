//
//  FavouriteViewPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 11.06.2024.
//

import UIKit

protocol FavouriteViewPresenterProtocol: AnyObject {
    var post: [PostItem]? { get set }
    init(view: FavouriteViewProtocol)
    func getPosts()
}

class FavouriteViewPresenter: FavouriteViewPresenterProtocol {
    
    var post: [PostItem]?
    private weak var view: FavouriteViewProtocol?
    
    required init(view: any FavouriteViewProtocol) {
        self.view = view
        getPosts()
    }
    
    func getPosts() {
        self.post = PostItem.getMockItems()
        self.view?.showPost()
    }
}


