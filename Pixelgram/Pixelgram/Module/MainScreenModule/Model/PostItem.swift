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
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL"), PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL"),
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL")
        ], date: Date().addingTimeInterval(-86400))]
    }
}

struct PostItem: Identifiable {
    let id = UUID().uuidString
    let photos: [String]
    let comments: [Comment]?
    let tag: [String]?
    let description: String?
    let isFavourite: Bool = false
}

struct Comment: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let comment: String
}
