//
//  PostItem.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 09.06.2024.
//

import Foundation
import CoreLocation

struct PostDate: Identifiable{
    let id = UUID().uuidString
    let items: [PostItem]
    let date: Date
    
    static func getMockData() -> [PostDate] {
        [ PostDate(items: [
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date(), location: nil),
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date(), location: nil),
            PostItem(photos: ["img1", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "BLALALSDLLSADLADL", isFavourite: false, date: Date(), location: nil)
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
    let location: CLLocationCoordinate2D?
    
    static func getMockItems() -> [PostItem] {
        [PostItem(photos: ["img3", "img1"], 
                  comments: [
                    Comment(date: Date(), comment: "kdsakdsakkdakkkkk"),
                    Comment(date: Date(), comment: "dasda"),
                    Comment(date: Date(), comment: "dsadsadadasdadas")
                            ],
                  tag: ["Дом", "Nature", "family", "NatureNatureNature", "NatureNature"],
                  description: "dsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadasdsadsadadasdadas",
                  isFavourite: true,
                  date: Date(),
                  location: CLLocationCoordinate2D(latitude: 40.728, longitude: -74)
                 ),
         PostItem(photos: ["img2", "img1"], comments: nil, tag: ["Дом", "Nature"], description: "dsadsadadasdadas", isFavourite: true ,date: Date(), location: nil),
         PostItem(photos: ["img3", "img2"], comments: nil, tag: ["Дом", "Nature"], description: "dsadsadadasdadas", isFavourite: true ,date: Date(), location: nil)
        ]
        
    }
}

struct Comment: Identifiable {
    let id = UUID().uuidString
    let date: Date
    let comment: String
}
