//
//  LibraryViewCell.swift
//  Spotify
//
//  Created by Dwistari on 06/01/25.
//

import UIKit

class LibraryViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var trackSong: UILabel!
    @IBOutlet weak var imagePlaylist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imagePlaylist.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
