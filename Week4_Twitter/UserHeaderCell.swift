//
//  UserHeaderCell.swift
//  Week4_Twitter
//
//  Created by Ian Campelo on 11/8/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userTweetsCountLabel: UILabel!
    @IBOutlet weak var userFollowingCountLabel: UILabel!
    @IBOutlet weak var userFollowersCountLabel: UILabel!
    
    var user: User! {
        didSet {
            userImageView.setImageWith((user.profileUrl)!)
            userNameLabel.text = user.name
            userHandleLabel.text = "@\((user.screenName)!)"
            
            userTweetsCountLabel.text = "\(user.tweetsCount!)"
            userFollowersCountLabel.text = "\(user.followersCount!)"
            userFollowingCountLabel.text = "\(user.followingCount!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = 3
        userImageView.clipsToBounds = true
    }

}
