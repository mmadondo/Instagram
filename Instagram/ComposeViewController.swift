//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CameraViewControllerDelegate {
    
    var selectedImage: UIImage?
    
    
    
    @IBAction func didPushCameraBtn(_ sender: Any) {
        let vc = UIImagePickerController()  //Instantiate a UIImagePickerController
        vc.allowsEditing = true
        vc.delegate = self
        
        //check if camera is supported on device before presenting it
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func didSubmit() {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func didPushLibraryBtn(_ sender: Any) {
        let vc = UIImagePickerController()  //Instantiate a UIImagePickerController
        vc.allowsEditing = true
        vc.delegate = self
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        //check if camera is supported on device before presenting it
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            print("Library is available")
            vc.sourceType = .photoLibrary
        } else {
            print("Camera is available 📸")
            vc.sourceType = .camera
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIImagePickerController()  //Instantiate a UIImagePickerController
        vc.allowsEditing = true
        vc.delegate = self
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        selectedImage = editedImage
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true) {
            self.performSegue(withIdentifier: "composeSegue", sender: self)
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! CameraViewController
        
        destination.pic = self.selectedImage
        destination.delegate = self
    }
    
    
}
