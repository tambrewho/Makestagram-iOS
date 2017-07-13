//
//  FindFriendsCell.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

protocol FindFriendsCellDelegate: class {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell)
}

class FindFriendsCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    
    weak var delegate: FindFriendsCellDelegate?
    // MARK: - Cell Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followButton.layer.borderColor = UIColor.lightGray.cgColor
        followButton.layer.borderWidth = 1
        followButton.layer.cornerRadius = 6
        followButton.clipsToBounds = true
        
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitle("Following", for: .selected)
    }
    
    // MARK: - IBActions
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
    
        delegate?.didTapFollowButton(sender, on: self)
    }
}
