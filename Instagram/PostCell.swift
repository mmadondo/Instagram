//
//  PostCell.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/27/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
