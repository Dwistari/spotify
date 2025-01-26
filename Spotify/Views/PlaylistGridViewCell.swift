//
//  PlaylistGridViewCell.swift
//  Spotify
//
//  Created by Dwistari on 24/01/25.
//

import UIKit

class PlaylistGridViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var items: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItemCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // UICollectionViewDelegateFlowLayout
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let itemsPerRow: CGFloat = 3
         let padding: CGFloat = 10
         let totalPadding = padding * (itemsPerRow + 1)
         let individualWidth = (collectionView.frame.width - totalPadding) / itemsPerRow
         return CGSize(width: individualWidth, height: individualWidth)
     }
    
}
