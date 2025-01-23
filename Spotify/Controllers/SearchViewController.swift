//
//  SearchViewController.swift
//  Spotify
//
//  Created by Dwistari on 05/01/25.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Album]?
    var keywordData: [String] = []
    let cellReuseIdentifier = "cell"
    var isHiddenNavbar: Bool = false
    var playlist: PlaylistEntity?
    
    lazy var viewModel: SearchViewModel = {
        let viewModel = SearchViewModel(service: MusicService())
        viewModel.didFinishLoadMusic = onFinishLoadMusic
        return viewModel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let nib = UINib(nibName: "AlbumViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        searchView.delegate = self
        searchView.placeholder = "What do you want to listen to?"
        searchView.sizeToFit()
        
        navigationController?.isNavigationBarHidden = isHiddenNavbar
    }
    
    func loadData(keyword: String) {
        viewModel.loadMusic(keyword: keyword)
    }
    
    func onFinishLoadMusic(data: [Album]) {
        DispatchQueue.main.async {
            self.albums = data
            self.tableView.reloadData()
        }
    }
    
    func saveSongToPlaylist(songTitle: String, artist: String, imageUrl: String, musicUrl: String) {
        let context = CoreDataManager.shared.context
        let song = Song(context: context)
        song.title = songTitle
        song.artist = artist
        song.image = imageUrl
        song.url = musicUrl
        
        playlist?.addToSongs(song)
        CoreDataManager.shared.saveContext()
        
        
//        let context = CoreDataManager.shared.context
//        
//        // Fetch the playlist or create a new one
//        let playlistFetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
//        playlistFetchRequest.predicate = NSPredicate(format: "name == %@", playlistName)
//        
//        var playlist: PlaylistEntity?
//        
//        do {
//            let playlists = try context.fetch(playlistFetchRequest)
//            if let existingPlaylist = playlists.first {
//                playlist = existingPlaylist
//            } else {
//                // Create a new playlist if one doesn't exist
//                playlist = PlaylistEntity(context: context)
//                playlist?.name = playlistName
//            }
//        } catch {
//            print("Failed to fetch playlist: \(error)")
//            return
//        }
//        
//        // Ensure songs relationship is initialized
//        if playlist?.songs == nil {
//            print("songs", "kozzonnggg")
//            
////            playlist?.songs = Set<Song>()
//        }
//        
//        // Create a new song and associate it with the playlist
//        let song = Song(context: context)
//        song.title = songTitle
//        song.artist = artist
//        song.image = imageUrl
//        song.url = musicUrl
//        song.playlist = playlist
//        
//        // Add the song to the playlist
//        playlist?.addToSongs(song)
//        
//        // Save the context
//        do {
//            try context.save()
//            print("Song added to playlist successfully!")
//        } catch {
//            print("Failed to save: \(error)")
//        }
    }
}



extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! AlbumViewCell
        
        cell.lblSinger.text =  self.albums?[indexPath.row].collectionName
        if let urlAlbumImg = self.albums?[indexPath.row].artworkUrl100 {
            cell.imgAlbum.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = albums?[indexPath.row]
        if !isHiddenNavbar {
            let vc = MusicPlayViewController()
            vc.selectedMusic = song
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.saveSongToPlaylist(songTitle: song?.collectionName ?? "", artist: song?.artistName ?? "", imageUrl: song?.artworkUrl100 ?? "", musicUrl: song?.previewUrl ?? "")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchSong = searchText.replacingOccurrences(of: " ", with: "+")
        print("searchSong", searchSong)

        loadData(keyword: searchText)
          tableView.reloadData()
      }
    
}
