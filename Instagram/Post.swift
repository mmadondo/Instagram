//
//  Post.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/28/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        if let image = image {
            let resizedImage = Post.resizeImage(image: image, targetSize: CGSize(width: 375, height: 375))
            post["media"] = getPFFileFromImage(image: resizedImage) // PFFile column type
        } else {
            // upload a placeholder image
        }
        
        post["author"] = PFUser.current() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground { (status: Bool, error: Error?) in
            completion?(status, error)
        }
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        // This is the rect that we've calculated out and this is what is actually used below
        let targetRect = CGRect(origin: CGPoint.zero, size: targetSize)
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: targetRect)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsGetCurrentContext()?.interpolationQuality = .high
        UIGraphicsBeginImageContextWithOptions(targetSize, false, 0)
        
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
}
