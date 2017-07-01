//
//  profilePosterCell.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/30/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class profilePosterCell: UICollectionViewCell {
    
    @IBOutlet weak var profilePosterImageView: PFImageView!
    
    var instaPost: PFObject!{
        didSet{
            self.profilePosterImageView.file = instaPost["media"] as? PFFile
            self.profilePosterImageView.loadInBackground()
        }

    }
    
}
