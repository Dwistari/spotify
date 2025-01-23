//
//  PlaylistEntity+CoreDataProperties.swift
//  Spotify
//
//  Created by Dwistari on 17/01/25.
//
//

import Foundation
import CoreData


extension PlaylistEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlaylistEntity> {
        return NSFetchRequest<PlaylistEntity>(entityName: "PlaylistEntity")
    }

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: Song)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: Song)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: Set<Song>)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: Set<Song>)
}

extension PlaylistEntity : Identifiable {

}
