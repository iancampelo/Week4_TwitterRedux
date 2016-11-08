//
//  Tweet.swift
//  Week3_Twitter
//
//  Created by Ian Campelo on 11/1/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit
import NSDate_TimeAgo

class Tweet: NSObject {
    var userProfilePicture: URL?
    var userBannerPicture: URL?
    var userName: String?
    var screenName: String?
    var tweetText: String?
    var createAt: String?
    var favoriteCount: Int?
    var favorited: Bool?
    var retweetCount: Int?
    var retweeted: Bool?
    var id: Int?
    
    
    
    var timetamp: String?
    
    init(dictionary: NSDictionary) {
        // get info user
        if let user = dictionary["user"] as? NSDictionary {
            // get avatar and banner
            if let userProfilePicture = user["profile_image_url_https"] as? String {
                self.userProfilePicture = URL(string: userProfilePicture)
            }
            if let userBannerPicture = user["profile_banner_url"] as? String {
                self.userBannerPicture = URL(string: userBannerPicture)
            }
            // get name and screen name
            if let userName = user["name"] as? String {
                self.userName = userName
            }
            if let screenName = user["screen_name"] as? String {
                self.screenName = screenName
            }
        }
        
        // get tweet text and time to create
        if let tweetText = dictionary["text"] as? String {
            self.tweetText = tweetText
        }
        if let createAt = dictionary["created_at"] as? String {
            self.createAt = createAt
            
            let formater = DateFormatter()
            formater.dateFormat = "EEE MMM d HH:mm:ss Z y"
            self.timetamp = (formater.date(from: createAt) as NSDate?)?.timeAgo() ?? ""
        }
        
        // get info about reaction of tweet
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let favoriteCount = dictionary["favorite_count"] as? Int {
            self.favoriteCount = favoriteCount
        }
        if let favorited = dictionary["favorited"] as? Bool {
            self.favorited = favorited
        }
        if let retweetCount = dictionary["retweet_count"] as? Int {
            self.retweetCount = retweetCount
        }
        if let retweeted = dictionary["retweeted"] as? Bool {
            self.retweeted = retweeted
        }
    }
    
    class func tweetWithArray(dictionary: [NSDictionary]) -> [Tweet] {
        var tweetArray = [Tweet]()
        
        for tweet in dictionary {
            tweetArray.append(Tweet(dictionary: tweet))
        }
        
        return tweetArray
    }
}
