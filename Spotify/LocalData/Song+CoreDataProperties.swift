//
//  Song+CoreDataProperties.swift
//  Spotify
//
//  Created by Dwistari on 17/01/25.
//
//

import Foundation
import CoreData


extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var artist: String?
    @NSManaged public var url: String?
    @NSManaged public var image: String?
    @NSManaged public var playlist: PlaylistEntity?

}

extension Song : Identifiable {

}
