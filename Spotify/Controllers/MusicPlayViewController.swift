//
//  MusicPlayViewController.swift
//  Spotify
//
//  Created by Dwistari on 13/01/25.
//

import UIKit
import AVFoundation

class MusicPlayViewController: UIViewController {
    
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var lblSongTitle2: UILabel!
    @IBOutlet weak var lblSinger: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    
    var selectedMusic: Album?
    var player: AVPlayer?
    var isPlayed: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    private func updateMusic() {
        lblSongTitle.text = selectedMusic?.collectionName
        lblSongTitle2.text = selectedMusic?.collectionName
        lblSinger.text = selectedMusic?.artistName
        if let urlAlbumImg = self.selectedMusic?.artworkUrl100 {
            albumImg.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
        }
    }
    
    @IBAction func playMusic(_ sender: Any) {
        isPlayed.toggle()

        if let player = player {
            if isPlayed {
                player.play()
            } else {
                player.pause()
            }
        } else {
            // Initialize the player if it doesn't exist
            guard let musicURL = URL(string: selectedMusic?.previewUrl ?? "") else { return }
            player = AVPlayer(url: musicURL)
            player?.play()
            print("Now playing: \(musicURL)")
        }
        
        print("isPlayed: \(isPlayed)")
        btnPlay.setImage(UIImage(systemName: isPlayed ? "pause.fill" : "play.fill"), for: .normal)
    }
    
}
