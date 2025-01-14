//
//  DetailPlaylistViewController.swift
//  Spotify
//
//  Created by Dwistari on 13/01/25.
//

import UIKit

class DetailPlaylistViewController: UIViewController {
    
    var selectedItem: PlaylistEntity?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

}
