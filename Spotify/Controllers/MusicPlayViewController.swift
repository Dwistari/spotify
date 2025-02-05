//
//  MusicPlayViewController.swift
//  Spotify
//
//  Created by Dwistari on 13/01/25.
//

import UIKit
import AVFoundation

class MusicPlayViewController: UIViewController {
    
    @IBOutlet weak var albumImg: UIImageView!
    @IBOutlet weak var lblSongTitle2: UILabel!
    @IBOutlet weak var lblSinger: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    
    var selectedMusic: Album?
    var selectSong: Song?
    var player: AVPlayer?
    var isPlayed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMusic()
        setupCustomNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupCustomNavigationBar() {
        self.navigationController?.setNavigationBarHidden(selectedMusic != nil, animated: false)
        customNavigationBar.title = (selectedMusic != nil ? selectedMusic?.collectionName ?? "" : selectSong?.title) ?? ""
        customNavigationBar.onLeftButtonTap = {
            print("onLeftButtonTap")
            self.navigationController?.popViewController(animated: true)
        }
        customNavigationBar.onRightButtonTap = {
            self.showPopup()
        }
    }
    
    private func updateMusic() {
        if let song = selectedMusic {
            lblSongTitle2.text = song.collectionName
            lblSinger.text = song.artistName
            if let urlAlbumImg = song.artworkUrl100 {
                albumImg.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
            }
        } else {
            lblSongTitle2.text = selectSong?.title
            lblSinger.text = selectSong?.artist
            if let urlAlbumImg = selectSong?.image {
                albumImg.loadImage(url: urlAlbumImg, placeholder: UIImage(named: "placeholder"))
            }
        }
    }
    
    
    func showPopup() {
        let vc = PopupViewController()
        vc.selectedMusic = selectedMusic
        vc.selectedSong = selectSong
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .pageSheet
        
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium()]
                sheet.preferredCornerRadius = 16
            }
        } else {
            // Fallback on earlier versions
        }

        present(nav, animated: true, completion: nil)
        
    }
    
    @IBAction func playMusic(_ sender: Any) {
        isPlayed.toggle()
        let songUrl = (selectedMusic != nil ? selectedMusic?.previewUrl ?? "" : selectSong?.url) ?? ""
        if let player = player {
            if isPlayed {
                player.play()
            } else {
                player.pause()
            }
        } else {
            guard let musicURL = URL(string: songUrl) else { return }
            player = AVPlayer(url: musicURL)
            player?.play()
        }
        btnPlay.setImage(UIImage(systemName: isPlayed ? "pause.fill" : "play.fill"), for: .normal)
    }
}

//class PopupViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemGray6
//        
//        let popupHeight: CGFloat = 300 // Custom height
//        let popupView = UIView(frame: CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: popupHeight))
//        popupView.backgroundColor = .white
//        popupView.layer.cornerRadius = 20
//        view.addSubview(popupView)
//        
//        UIView.animate(withDuration: 0.3) {
//            popupView.frame.origin.y = self.view.frame.height - popupHeight
//        }
//    }
//    
//    @objc func dismissPopup() {
//        dismiss(animated: true, completion: nil)
//    }
//}
