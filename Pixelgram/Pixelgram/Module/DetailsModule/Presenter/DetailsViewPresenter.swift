//
//  DetailsViewPresenter.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 12.06.2024.
//

import UIKit

protocol DetailsViewPresenterProtocol: AnyObject {
    var item: PostItem { get }
    init(view: DetailsViewProtocol, item: PostItem)
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    private weak var view: DetailsViewProtocol?
    var item: PostItem
    
    required init(view: any DetailsViewProtocol, item: PostItem) {
        self.view = view
        self.item = item
    }
    
    
  
}
