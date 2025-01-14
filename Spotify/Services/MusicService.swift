//
//  MusicService.swift
//  Spotify
//
//  Created by Dwistari on 05/01/25.
//

import Foundation

protocol MusicServiceProtocol {
    func fetchMusic(keyword: String, completion: @escaping (Result<AlbumResponse, Error>) -> Void)
}

class MusicService: MusicServiceProtocol {
    func fetchMusic(keyword: String, completion: @escaping (Result<AlbumResponse, any Error>) -> Void) {
        let endpoin = "https://itunes.apple.com/search?term=\(keyword)&media=music"
        NetworkManager.shared.request(url: endpoin, completion: completion)
    }
    
}
