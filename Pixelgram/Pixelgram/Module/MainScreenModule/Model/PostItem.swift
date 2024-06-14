//
//  PostItem.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import Foundation

struct PostDate: Identifiable{
    let id = UUID().uuidString
    let items: [PostItem]
    let date: Date
    
    static func getMockData() -> [PostDate] {
        [ PostDate(items: [
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date()),
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date()),
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date())
        ], date: Date().addingTimeInterval(-86400))]
    }
}

struct PostItem: Identifiable {
    let id = UUID().uuidString
    let photos: [String]
    let comments: [Comment]?
    let tag: [String]?
    let description: String?
    let isFavourite: Bool
    let date: Date
    
    static func getMockItems() -> [PostItem] {
        [PostItem(photos: ["img3", "img1"], comments: nil, tag: ["Дом", "Nature", "family", "NatureNatureNature", "NatureNature"], description: "dsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadas", isFavourite: true ,date: Date()),
         PostItem(photos: ["img2", "img1"], comments: nil, tag: ["Дом", "Nature"], description: "dsadsadadasdadas", isFavourite: true ,date: Date()),
         PostItem(photos: ["img3", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "dsadsadadasdadas", isFavourite: true ,date: Date())
        ]
        
    }
}

struct Comment: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let comment: String
}
