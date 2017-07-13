//
//  User.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/6/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: NSObject {
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    var isFollowed = false
    
    // 1. singleton var
    private static var _current: User?
    
    // MARK: - Init
    
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    //failable init
    //return nil if uid/username doesn't exist
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
    
    // MARK: - Singleton
    // computable var that gets private _ current var
    static var current: User {
        // check if currentUser is nil
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        // if not nil, return
        return currentUser
    }
    
    // MARK: - Class Methods
    // set method for var
    // should user be written to user defaults?
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // if bool is true then write user to user defauls
        if writeToUserDefaults {
            // turn user objct into data
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // store data with current user
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }
}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}




