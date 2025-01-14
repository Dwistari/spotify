//
//  PlaylistEntity+CoreDataProperties.swift
//  Spotify
//
//  Created by Dwistari on 12/01/25.
//
//

import Foundation
import CoreData


extension PlaylistEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaylistEntity> {
        return NSFetchRequest<PlaylistEntity>(entityName: "PlaylistEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var createAt: Date?
    @NSManaged public var id: Int64

}

extension PlaylistEntity : Identifiable {

}
