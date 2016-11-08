//
//  TweetCell.swift
//  Week3_Twitter
//
//  Created by Ian Campelo on 11/1/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet{
            if let avatar = tweet.userProfilePicture {
                profileImageView.setImageWith(avatar)
            }
            usernameLabel.text = tweet.userName
            //screenNameLabel.text = "@\(tweet.screenName!)"
            timestampLabel.text = tweet.timetamp!
            tweetTextLabel.text = tweet.tweetText
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
