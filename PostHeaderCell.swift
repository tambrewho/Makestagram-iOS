//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
     static let height: CGFloat = 54
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("options button tapped")
    }
}
