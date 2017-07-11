//
//  PostService.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight)
        }
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
        // creates reference to currentUser
        let currentUser = User.current
        // initialize a new post
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        // convert new post object to dictionary
        let dict = post.dictValue
        
        // construct path to new post data location
        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
        //write data to specified location
        postRef.updateChildValues(dict)
    }
}
