 //
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/6/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    //@IBOutlet weak var nextButtonTapped: UIButton!
    @IBOutlet weak var nextButtonTapped: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        // @IBOutlet
//        weak var nextButtonTapped: UIButton!
        nextButton.layer.cornerRadius = 6
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        //user will be stored in UserDefaults whenever they log on
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                // handle error
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
    
}
