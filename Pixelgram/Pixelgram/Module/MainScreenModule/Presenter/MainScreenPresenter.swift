//
//  MainScreenPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import Foundation


protocol MainScreenPresenterProtocol: AnyObject {
    init(view: MainScreenViewProtocol)
    var posts: [PostDate]? { get set }
    func getPosts()
}

class MainScreenPresenter {
    
    weak var view: MainScreenViewProtocol?
    var posts: [PostDate]?
    
    required init(view: MainScreenViewProtocol) {
        self.view = view
        getPosts()
    }
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func getPosts() {
        self.posts = PostDate.getMockData()
        view?.showPosts()
    }
}
