//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Dwistari on 06/01/25.
//

import Foundation

class SearchViewModel {
    
    private let service: MusicServiceProtocol
    
    var didFinishLoadMusic : ((_ datas: [Album] ) -> Void)?
    var albumResults: [Album] = []
    var errors: [Error] = []
    
    init(service: MusicServiceProtocol) {
        self.service = service
    }
    
    
    func loadMusic(keyword: String) {
        service.fetchMusic(keyword: keyword) { result in
            switch result {
            case .success(let music):
                self.didFinishLoadMusic?(music.results)                
            case .failure(let error):
                self.errors.append(error)
            }
        }
    }
}
