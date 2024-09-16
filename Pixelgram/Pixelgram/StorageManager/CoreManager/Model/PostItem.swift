//
//  PostItem+CoreDataClass.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 19.06.2024.
//
//

import Foundation
import CoreData

@objc(PostItem)
public class PostItem: NSManagedObject {

}


extension PostItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostItem> {
        return NSFetchRequest<PostItem>(entityName: "PostItem")
    }

    @NSManaged public var id: String?
    @NSManaged public var photos: [String]?
    @NSManaged public var tags: [String]?
    @NSManaged public var postDescription: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var date: Date?
    @NSManaged public var long: Double
    @NSManaged public var lat: Double
    @NSManaged public var parent: PostData?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension PostItem {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

extension PostItem : Identifiable {
    
    func toggleFavorite(isFavourite: Bool) {
        self.isFavourite = !isFavourite
        
        try? managedObjectContext?.save()
    }
}
