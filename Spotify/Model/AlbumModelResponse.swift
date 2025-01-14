//
//  AlbumModelResponse.swift
//  Spotify
//
//  Created by Dwistari on 04/01/25.
//

import Foundation

struct AlbumResponse: Codable {
    let resultCount: Int
    let results: [Album]
}

struct Album: Codable {
    let wrapperType: String?
    let collectionType: String?
    let artistId: Int?
    let collectionId: Int?
    let amgArtistId: Int?
    let artistName: String
    let collectionName: String?
    let collectionCensoredName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let previewUrl: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionExplicitness: String?
    let trackCount: Int?
    let copyright: String?
    let country: String?
    let currency: String?
    let releaseDate: String?
    let primaryGenreName: String?
    
    // You can add computed properties for easier handling
    var formattedPrice: String {
        return String(format: "$%.2f", collectionPrice ?? 0.0)
    }
}

//typealias AlbumResponse = [Album] // If the response is an array of albums

