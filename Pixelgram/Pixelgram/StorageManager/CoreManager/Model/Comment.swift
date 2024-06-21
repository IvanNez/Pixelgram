//
//  Comment+CoreDataClass.swift
//  Pixelgram
//
//  Created by Иван Незговоров on 19.06.2024.
//
//

import Foundation
import CoreData

@objc(Comment)
public class Comment: NSManagedObject {

}

extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var id: String?
    @NSManaged public var date: Date?
    @NSManaged public var comment: String?
    @NSManaged public var parrent: PostItem?

}

extension Comment : Identifiable {

}
