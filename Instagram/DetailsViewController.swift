//
//  DetailsViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/29/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var detailImageView: PFImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var myInstaPost: PFObject!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let myInstaPost = myInstaPost{
            
            detailImageView.file = myInstaPost["media"] as? PFFile
            captionLabel.text = myInstaPost["caption"] as? String
            let name = myInstaPost["author"] as! PFUser
            nameLabel.text = name.username! + " posted a new pic:"
            
            if let postTime = myInstaPost.createdAt{
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short //medium
                dateFormatter.timeStyle = .short
                
                let timeStr = dateFormatter.string(from: postTime)
                timeLabel.text = "On " + timeStr
            }
            
            //self.performSegue(withIdentifier: "detailSegue", sender: self)
            
            detailImageView.loadInBackground()
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
    }
    */

}
