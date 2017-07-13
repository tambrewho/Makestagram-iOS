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
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        
        // create references to important locations
        let rootRef = Database.database().reference()
        let newPostRef = rootRef.child("posts").child(currentUser.uid).childByAutoId()
        let newPostKey = newPostRef.key
        
        // get array of UIDs
        UserService.followers(for: currentUser) { (followerUIDs) in
            // construct a timeline JSON object where we store our current user's uid
            let timelinePostDict = ["poster_uid" : currentUser.uid]
            
            // create mutable dictionary that stores the data written to the database
            var updatedData: [String : Any] = ["timeline/\(currentUser.uid)/\(newPostKey)" : timelinePostDict]
            
            // add post to follower's timelines
            for uid in followerUIDs {
                updatedData["timeline/\(uid)/\(newPostKey)"] = timelinePostDict
            }
            
            // write the posts
            let postDict = post.dictValue
            updatedData["posts/\(currentUser.uid)/\(newPostKey)"] = postDict
            
            // write multi-location update
            rootRef.updateChildValues(updatedData)
        }
    }
    
    static func show(forKey postKey: String, posterUID: String, completion: @escaping (Post?) -> Void) {
        let ref = Database.database().reference().child("posts").child(posterUID).child(postKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let post = Post(snapshot: snapshot) else {
                return completion(nil)
            }
            
            LikeService.isPostLiked(post) { (isLiked) in
                post.isLiked = isLiked
                completion(post)
            }
        })
    }
}
