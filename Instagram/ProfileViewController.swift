//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
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
    
    
    var instaPosts: [PFObject] = []
    var myInstaPost: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authorLabel.text = "zChat"
        collectionView.dataSource = self
        fetchImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instaPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profilePosterCell", for: indexPath) as! profilePosterCell
        
        let image = self.instaPosts[indexPath.row]
        
        cell.instaPost = image
        
        
        return cell
    }
    
    
    func fetchImages() {
        
        
        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20 + instaPosts.count
        
       // let post = instaPosts[indexPath.section]
        //let name = myInstaPost["author"] as! PFUser
        
        //authorLabel.text = name.username!
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                
                print(error.localizedDescription) //handle error
                
            } else if let posts = posts {
                
                self.instaPosts = posts
                
                //let name = posts["author"] as? String
                
                //authorLabel.text = name
                
                /*for post in self.instaPosts {
                 let caption = post["caption"] as! String
                 //print(caption)
                 }*/
                
                self.collectionView.reloadData()
            }
            
            //self.refreshCtrl.endRefreshing()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
