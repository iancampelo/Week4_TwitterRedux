//
//  TwitterClient.swift
//  Week3_Twitter
//
//  Created by Ian Campelo on 11/1/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "aIlNvximikrwuTuiCbvozWfe6", consumerSecret: "5rwL9cPLoFYMcx5joqNuSFMDtxkCU0UZnzJEjttYgdQyfkS19Q")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetWithArray(dictionary: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error as NSError)
        })
    }
    
    func userTimeline(screenName: String, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/user_timeline.json", parameters: ["screen_name": screenName], progress: nil, success: { (task :URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetWithArray(dictionary: dictionaries)
            
            print("\nI got user tweets \nCount:\(tweets.count)\n")
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }
    
    func mentionsTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/mentions_timeline.json", parameters: nil, progress: nil, success: { (task :URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetWithArray(dictionary: dictionaries)
            
            print("\nI got user mentions \nCount:\(tweets.count)\n")
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                failure(error)
        })
    }

    
    func getCurrentUser(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("Account: \(response)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            }, failure: { (taskError: URLSessionDataTask?, error: Error) in
                failure(error as NSError)
        })
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.getCurrentUser(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) in
                self.loginFailure?(error)
            })
            
            
            
        }, failure: { (error: Error?) in
            print("Error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterapp://oauth"), scope: nil, success: { (request:BDBOAuth1Credential?) in
            
            if let token = request?.token{
                let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token)")!
                UIApplication.shared.open(url)
            }
            }, failure: { (error: Error?) in
                print("F*ck, got this error: \(error?.localizedDescription)")
                self.loginFailure?(error as! NSError)
        })

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)
        
    }
    
    func compose(text: String, idTweetToReply: Int?, handleSuccess: @escaping () -> ()) {
        var params = [String: Any]()
        params["status"] = text as Any?
        if let idTweet = idTweetToReply {
            params["in_reply_to_status_id"] = idTweet
        }
        
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("compose success")
            
            handleSuccess()
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        }
    }
    
    func retweet(idTweet: Int, handleSuccess: @escaping () -> ()) {
        post("1.1/statuses/retweet/\(idTweet).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            handleSuccess()
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        }
    }
    
    func unretweet(idTweet: Int, handleSuccess: @escaping () -> ()) {
        post("1.1/statuses/unretweet/\(idTweet).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            handleSuccess()
        }) { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        }
    }

    
}
