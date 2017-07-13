//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Tambre Hu on 7/12/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}

class PostActionCell: UITableViewCell{
    
    static let height: CGFloat = 46
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    weak var delegate: PostActionCellDelegate?
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
}
