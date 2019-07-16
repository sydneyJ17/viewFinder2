//
//  AddPhotoViewController.swift
//  viewFinder
//
//  Created by Apple on 7/16/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

        var imagePicker = UIImagePickerController()
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var captionText: UITextField!
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            imagePicker.delegate = self
        }
        
    
        @IBAction func takeSelfieTapped(_ sender: UIButton) {
            imagePicker.sourceType = .camera
            
            present(imagePicker , animated: true, completion: nil)
        }
    
    
        @IBAction func libraryButtonTapped(_ sender: UIButton) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true , completion: nil)
        }
    
    
        @IBAction func albumsButtonTapped(_ sender: UIButton){
            imagePicker.sourceType = .savedPhotosAlbum
            present(imagePicker, animated: true , completion: nil)

        }
   
    
    @IBAction func savePhotoTapped (_sender: UIButton){
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let photoToSave = Photos(entity: Photos.entity() , insertInto: context)
            photoToSave.caption = captionText.text
        
            
        //if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            
            if let userImage = imageView.image {
                
                
                if let userImageData = userImage.pngData() {
                    
                    photoToSave.imageData = userImageData
                
                }
                
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            navigationController?.popViewController(animated: true)
            
        }
}
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage]as? UIImage{imageView.image = selectedImage}
        
        imagePicker.dismiss(animated: true, completion: nil)
    }

   

    

}
