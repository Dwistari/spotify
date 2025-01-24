//
//  CreatePlaylistController.swift
//  Spotify
//
//  Created by Dwistari on 06/01/25.
//

import UIKit
import CoreData

class CreatePlaylistController: UIViewController {
    
    
    @IBOutlet weak var txtPlaylistName: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    var didSavedPlaylist: ((_ playlist: PlaylistEntity) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func create(_ sender: Any) {
        addPlaylist(name: txtPlaylistName.text ?? "") { data in
            if let playlist = data {
                self.didSavedPlaylist?(playlist)
                print("Playlist added successfully!")
            } else {
                print("Failed to add playlist.")
            }
        }
        self.dismiss(animated: true)
    }
    
    private func addPlaylist(name: String, completion: @escaping (PlaylistEntity?) -> Void) {
        let persistent = CoreDataManager.shared
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        var newID: Int64 = 1
           do {
               if let lastPlaylist = try persistent.context.fetch(fetchRequest).first {
                   newID = lastPlaylist.id + 1
               }
           } catch {
               print("Failed to fetch max ID: \(error.localizedDescription)")
               completion(nil)
               return
           }
        
        do {
            let playlist = PlaylistEntity(context: persistent.context)
            playlist.name = name
            playlist.id = newID
            playlist.createAt = Date()
            try persistent.context.save()
            completion(playlist)
            
        } catch {
            print("Core Data operation failed: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
