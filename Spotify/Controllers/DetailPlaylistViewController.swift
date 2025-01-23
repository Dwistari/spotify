//
//  DetailPlaylistViewController.swift
//  Spotify
//
//  Created by Dwistari on 13/01/25.
//

import UIKit

class DetailPlaylistViewController: UIViewController {
    
    @IBOutlet weak var playlistnameLbl: UILabel!
    @IBOutlet weak var totalSongLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var cellReuseIdentifier = "cell"
    var playlistName: String = ""
    var selectedItem: PlaylistEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        playlistnameLbl.text = playlistName != "" ? playlistName : selectedItem?.name
        
        if let song = selectedItem?.songs {
            totalSongLbl.text = "\(song.count)" + " total songs"
        }
        
        setTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        setupNavbar(color: .purple)
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        setupNavbar(color: .black)
    }
    
    private func setupNavbar(color: UIColor) {
        navigationController?.isNavigationBarHidden = false
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        
        let rightIcon = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        rightIcon.tintColor = .white
        navigationItem.rightBarButtonItem = rightIcon
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setTableView() {
        let nib = UINib(nibName: "AlbumViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "searchView") as? SearchViewController else {
            print("Failed to instantiate SearchViewController")
            return
        }
        vc.isHiddenNavbar = true
        vc.playlist = selectedItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension DetailPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("check-song", self.selectedItem?.songs ?? "kozoongg")

        return self.selectedItem?.songs?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! AlbumViewCell
        
        if let songs = self.selectedItem?.songs {
            let songsArray = Array(songs)
            
            cell.lblSinger.text = songsArray[indexPath.row].title
            if let urlAlbumImg = songsArray[indexPath.row].image {
                cell.imgAlbum.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
            }
        }
        return cell
    }
    
    
}
