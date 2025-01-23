//
//  PopupViewController.swift
//  Spotify
//
//  Created by Dwistari on 16/01/25.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var allbumImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var singerLbl: UILabel!
    @IBOutlet weak var addPlaylistView: UIView!
    @IBOutlet weak var shareView: UIView!
    var selectedMusic: Album?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = selectedMusic?.collectionName
        singerLbl.text = selectedMusic?.artistName

        let tapPlaylist = UITapGestureRecognizer(target: self, action: #selector(addPlaylist))
        addPlaylistView.addGestureRecognizer(tapPlaylist)
       
        let tapShare = UITapGestureRecognizer(target: self, action: #selector(shareMusic))
        shareView.addGestureRecognizer(tapShare)
        
    }
    
    @objc func addPlaylist() {
      
    }
    
    
    @objc func shareMusic() {
        let textToShare = "Check out this amazing content!"
        let urlToShare = URL(string: "https://www.example.com")!
        let itemsToShare: [Any] = [textToShare, urlToShare]
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
