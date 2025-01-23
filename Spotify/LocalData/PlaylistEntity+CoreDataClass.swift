//
//  PlaylistEntity+CoreDataClass.swift
//  Spotify
//
//  Created by Dwistari on 17/01/25.
//
//

import Foundation
import CoreData

@objc(PlaylistEntity)
public class PlaylistEntity: NSManagedObject {
    @NSManaged public var createAt: Date?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var songs: Set<Song>?
}

