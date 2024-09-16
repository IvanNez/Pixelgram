//
//  UIImageExt.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 12.09.2024.
//

import UIKit

extension UIImage {
    
    static func getCoverPhoto(folderID: String?, photosName: [String]?) -> UIImage? {
        guard let folderID else { return nil}
        let imagesName = StorageManager.shared.getPhotos(postID: folderID, photos: photosName ?? [])
        if let photoData = imagesName.first {
            return UIImage(data: photoData)
        }
        return nil
    }
    
    static func getOneImage(folderID: String, photo: String) -> UIImage? {
        let imageName = StorageManager.shared.getPhoto(postID: folderID, imageName: photo)
        if let imageName {
            return UIImage(data: imageName)
        }
    }
}
