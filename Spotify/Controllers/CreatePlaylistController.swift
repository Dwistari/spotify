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
    
    var didSavedPlaylist: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func create(_ sender: Any) {
        addPlaylist(name: txtPlaylistName.text ?? "") { success in
            if success {
                   print("Playlist added successfully!")
               } else {
                   print("Failed to add playlist.")
               }
        }
        
        didSavedPlaylist?()
        self.dismiss(animated: true)
    }
    
    private func addPlaylist(name: String, completion: @escaping (Bool) -> Void) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
            completion(false)
            return
        }
        
        let fetchRequest: NSFetchRequest<PlaylistEntity> = PlaylistEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        var newID: Int64 = 1
           do {
               if let lastPlaylist = try context.fetch(fetchRequest).first {
                   newID = lastPlaylist.id + 1
               }
               
               print("newID-1",newID)
           } catch {
               print("Failed to fetch max ID: \(error.localizedDescription)")
               completion(false)
               return
           }
        
        do {
            let playlist = PlaylistEntity(context: context)
            playlist.name = name
            playlist.id = newID
            playlist.createAt = Date()
            try context.save()
            completion(true)
            
        } catch {
            print("Core Data operation failed: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
