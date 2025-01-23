//
//  LibraryViewContoller.swift
//  Spotify
//
//  Created by Dwistari on 03/01/25.
//

import UIKit

class LibraryViewContoller: UIViewController {
    
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnGrid: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var playlist: [PlaylistEntity]?
    
    let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "LibraryViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        loadPlaylist()
    }
    
    private func loadPlaylist() {
        showPlaylist { playlists in
            if let playlists =  playlists {
                self.playlist = playlists
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addPlaylist(_ sender: Any) {
        let createVc = CreatePlaylistController()
        createVc.didSavedPlaylist = {
            let vc = DetailPlaylistViewController()
            vc.playlistName = createVc.txtPlaylistName.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            self.loadPlaylist()
        }
        self.present(createVc, animated: true, completion: nil)
    }
    
    private func showPlaylist(handler: @escaping (_ people: [PlaylistEntity]?) -> Void) {
        let persistent = CoreDataManager.shared
        do {
            let people = try persistent.context.fetch(PlaylistEntity.fetchRequest())
            handler(people)
        } catch {
            print("Failed to fetch data: \(error.localizedDescription)")
            handler(nil)
        }
    }
    
    private func openDetailPlaylist() {
        let vc = DetailPlaylistViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
}

extension LibraryViewContoller: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LibraryViewCell
        cell.lblName.text =  self.playlist?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailPlaylistViewController()
        vc.selectedItem = playlist?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
