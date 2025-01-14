//
//  HomeService.swift
//  Spotify
//
//  Created by Dwistari on 04/01/25.
//

import Foundation

protocol AlbumServiceProtocol {
    func fetchAlbums(completion: @escaping (Result<AlbumResponse, Error>) -> Void)
}


class AlbumService: AlbumServiceProtocol {
    
    func fetchAlbums(completion: @escaping (Result<AlbumResponse, any Error>) -> Void) {
        let endpoin = "https://itunes.apple.com/search?term=pop&limit=50&media=music&entity=album"
        NetworkManager.shared.request(url: endpoin, completion: completion)
    }
    
}
