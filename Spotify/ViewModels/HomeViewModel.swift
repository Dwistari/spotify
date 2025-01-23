//
//  HomeViewModel.swift
//  Spotify
//
//  Created by Dwistari on 05/01/25.
//

import Foundation

class HomeViewModel {
    
    private let service: AlbumServiceProtocol
    
    var albumResults: [Album] = []
    var errors: [Error] = []
    
    var didFinishLoadAlbums : ((_ datas: [Album] ) -> Void)?
    
    init(service: AlbumServiceProtocol) {
        self.service = service
    }
    
    
    func loadAlbums() {
        service.fetchAlbums { result in
            switch result {
            case .success(let albums):
                self.didFinishLoadAlbums?(albums.results)
                self.albumResults.append(contentsOf: albums.results)
            case .failure(let error):
                self.errors.append(error)
            }
        }        
    }
}
