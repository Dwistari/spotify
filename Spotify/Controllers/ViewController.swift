//
//  ViewController.swift
//  Spotify
//
//  Created by Dwistari on 11/12/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var albums              : [Album]?
    let cellReuseIdentifier = "cell"

    lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel(service: AlbumService())
        viewModel.didFinishLoadAlbums = onFinishLoadAlbums
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "AlbumViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        viewModel.loadAlbums()
    }
    
    func onFinishLoadAlbums(data: [Album]) {
        DispatchQueue.main.async {
            self.albums = data
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! AlbumViewCell
        
        cell.lblSinger.text =  self.albums?[indexPath.row].collectionName
        if let urlAlbumImg = self.albums?[indexPath.row].artworkUrl100 {
            cell.imgAlbum.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
            
        }
        
        return cell
    }
    
}
