import UIKit

class PhotoTableViewController: UITableViewController {
    
    var photos : [Photos] = []
    
    func getPhotos() {
    
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
    
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
                photos = coreDataPhotos
                tableView.reloadData()
            }
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool){
        getPhotos()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let cellPhoto = photos[indexPath.row]
        
        cell.textLabel?.text = "text"
        
        if let cellPhotoImageData = cellPhoto.imageData {
            
            if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                cell.imageView?.image = cellPhotoImage
            }
        }
    

        return cell
    
}
    
    
    
        override func tableView(_ tableView: UITableView , didSelectRowAt indexPath: IndexPath){
            performSegue(withIdentifier: "moveToDetail", sender: photos[indexPath.row])
        }
    
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "moveToDetail" {
                
                if let photoDetailView = segue.destination as? PhotoDetailViewController {
                    
                    if let photoToSend = sender as? Photos {
                        photoDetailView.photo = photoToSend
                    }
                    
                }
                
            }
        }
    

    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let photoToDelete = photos[indexPath.row]
                context.delete(photoToDelete)
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                getPhotos()
                
            }
            
        }
    }
    
}
