//
//  CameraViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

protocol CameraViewControllerDelegate {
    func didSubmit()
}

class CameraViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var captionField: UITextField!
    
    var pic: UIImage?
    var captionText = ""
    
    var delegate: CameraViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView.image = pic
        
        // Do any additional setup after loading the view.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //hide keyboard
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let caption = captionField.text ?? ""
        
        Post.postUserImage(image: pic, withCaption: caption) { (success: Bool, error: Error?) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                print("success!")
                if let tabBarController = self.tabBarController {
                    print("tab bar found")
                    tabBarController.selectedIndex = 0
                } else {
                    print("tab bar not found")
                }
                self.delegate?.didSubmit()
                self.dismiss(animated: true, completion: nil)
                //self.performSegue(withIdentifier: "homeTabSegue", sender: self)
            }
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! HomepageViewController
        vc.refresh()
    }*/

}
