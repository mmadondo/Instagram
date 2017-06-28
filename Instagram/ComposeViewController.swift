//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let vc = UIImagePickerController()  //Instantiate a UIImagePickerController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.camera
        
        
        //check if camera is supported on device before presenting it
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
