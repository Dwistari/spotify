//
//  SearchViewController.swift
//  Spotify
//
//  Created by Dwistari on 05/01/25.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchView: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var albums: [Album]?
    var keywordData: [String] = []
    let cellReuseIdentifier = "cell"

    lazy var viewModel: SearchViewModel = {
        let viewModel = SearchViewModel(service: MusicService())
        viewModel.didFinishLoadMusic = onFinishLoadMusic
        return viewModel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "AlbumViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)

        searchView.delegate = self
        searchView.placeholder = "What do you want to listen to?"
        searchView.sizeToFit()
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
        let vc = MusicPlayViewController()
        vc.selectedMusic = albums?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchSong = searchText.replacingOccurrences(of: " ", with: "+")
        print("searchSong", searchSong)

        loadData(keyword: searchText)
                
//          if searchText.isEmpty {
//              keywordData = data
//          } else {
//              keywordData = data.filter { $0.lowercased().contains(searchText.lowercased()) }
//          }
          tableView.reloadData()
      }
    
}
