//
//  StorageService.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/10/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseStorage

struct StorageService {
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // change image from UIImage to data
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        // upload media data to the parameter path
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // check if there is an error; if so then return nil
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            // return download URL for image
            completion(metadata?.downloadURL())
        })
    }
}

