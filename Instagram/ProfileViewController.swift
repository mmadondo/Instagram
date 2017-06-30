//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    
    @IBAction func signOutButton(_ sender: Any) {
        
        PFUser.logOutInBackground { (error: Error?) in
            // PFUser.currentUser() will now be nil
            if let error = error {
                print(error.localizedDescription)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                
                self.present(LoginViewController, animated: true, completion: {
                })
                
            }
        
        print("You have been logged out")
    }
}

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
