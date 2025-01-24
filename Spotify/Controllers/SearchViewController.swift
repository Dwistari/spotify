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
        
        if let dataPlay = playlist {
            print("dataPlay", dataPlay)
        } else {
            print("playlist ksong")
        }
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
        
        if let play = playlist {
            print("playlist", play.name ?? "ada isinya")
        } else {
            print("playlist-kosong")
        }
        
        print("saveSongToPlaylist")
        
        print("songTitle",songTitle)
        print("artist",artist)
        print("imageUrl",imageUrl)
        print("musicUrl",musicUrl)

        do {
            try context.save()
            print("Song added to playlist successfully!")
        } catch {
            print("Failed to save: \(error)")
        }
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

        loadData(keyword: searchSong)
          tableView.reloadData()
      }
    
}
