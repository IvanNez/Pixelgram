//
//  StorageManager.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 12.09.2024.
//

import Foundation

protocol StorageManagerProtocol: AnyObject {
    func savePhotos(postID: String, photos: [Data?]) -> [String]
    func getPhotos(postID: String, photos: [String]) -> [Data]
}

class StorageManager: StorageManagerProtocol{
    
    static let shared = StorageManager()
    private init() {}
    
    private func getPath() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func savePhotos(postID: String, photos: [Data?]) -> [String] {
        var photoNames: [String] = []
        photos.forEach {
            guard let photoData = $0 else { return }
            let photoName = savePhoto(postID: postID, photo: photoData)
            photoNames.append(photoName)
        }
        return photoNames
    }
    
    func getPhotos(postID: String, photos: [String]) -> [Data] {
        var photosData = [Data]()
        var path = getPath().appending(path: postID)
        
        photos.forEach {
            path.append(path: $0)
            
            if let photoData = try? Data(contentsOf: path) {
                photosData.append(photoData)
            }
        }
        return photosData
    }
    
    func getPhoto(postID: String, imageName: String) -> Data? {
        var path = getPath().appending(path: postID).appending(path: imageName)
        if let photoData = try? Data(contentsOf: path) {
            return photoData
        }
        return nil
    }
    
    private func savePhoto(postID: String, photo: Data) -> String {
        let name = UUID().uuidString + ".jpeg"
        var path = getPath().appending(path: postID)
       
        do {
            try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
            path.append(path: name)
            try photo.write(to: path)
        } catch {
            print(error.localizedDescription)
        }
        return name
    }
}
