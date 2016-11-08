//
//  TweetsViewController.swift
//  Week3_Twitter
//
//  Created by Ian Campelo on 11/1/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit
import MBProgressHUD


class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TypeTweetViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }, failure: { (error: NSError) in
                print("Error: \(error.localizedDescription)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweetButton(_ sender: AnyObject) {
        
        let storyboart = UIStoryboard(name: "Main", bundle: nil)
        let replyVC = storyboart.instantiateViewController(withIdentifier: "typeTweetViewController") as! TypeTweetViewController
        
        replyVC.isReply = false
        replyVC.delegate = self
        
        // open view
        replyVC.modalPresentationStyle = .overFullScreen;
        replyVC.view.backgroundColor = UIColor.clear
        self.present(replyVC, animated: true, completion: nil)
    }
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath as IndexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func addNewTweet(typeTweetViewController: TypeTweetViewController, tweetText: String) {
        let newTweet = createNewTweet(textTweet: tweetText)
        tweets.insert(newTweet, at: 0)
        tableView.reloadData()
    }
    func createNewTweet(textTweet: String) -> Tweet {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        let dateStr = formatter.string(from: date as Date)
        let tweetDic: [String: Any?] = ["created_at" : dateStr,
                                        "favorite_count" : 0,
                                        "favorited" : false,
                                        "id" : 0,
                                        "retweet_count" : 0,
                                        "retweeted" : false,
                                        "text" : textTweet,
                                        "user" : ""        ]
        
        let newTweet = Tweet(dictionary: tweetDic as NSDictionary)
        return newTweet
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
