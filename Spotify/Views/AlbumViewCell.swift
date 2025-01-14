//
//  SingerViewCell.swift
//  Spotify
//
//  Created by Dwistari on 03/01/25.
//

import UIKit

class AlbumViewCell: UITableViewCell {
    
    @IBOutlet weak var imgAlbum: UIImageView!
    @IBOutlet weak var lblSinger: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
