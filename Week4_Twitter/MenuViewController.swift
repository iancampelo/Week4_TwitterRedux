//
//  MenuViewController.swift
//  Week4_Twitter
//
//  Created by Ian Campelo on 11/8/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var profileNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    private var tweetsNavigationController: UIViewController!
    
    var viewControllers = [UIViewController]()
    var hamburgerViewController: HamburgerViewController!
    
    let titles: [String] = ["Profile", "Timeline", "Mentions"]
    var icons: [UIImage] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
        tweetsNavigationController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
        
        viewControllers.append(profileNavigationController)
        viewControllers.append(tweetsNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        hamburgerViewController.contentViewController = tweetsNavigationController
        
        let userIcon = UIImage(named: "user")
        let homeIcon = UIImage(named: "home")
        let mentions = UIImage(named: "mentions")
        
        icons.append(userIcon!)
        icons.append(homeIcon!)
        icons.append(mentions!)
        
        tableView.separatorColor = UIColor.white
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.menuItemLabel.text = titles[indexPath.row]
        cell.menuIconImageView.image = icons[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = viewControllers[indexPath.row]
        let childrenViewControllers = viewController.childViewControllers
        
        
        if childrenViewControllers[0] is ProfileViewController {
            let viewControllerReference = childrenViewControllers[0] as! ProfileViewController
            viewControllerReference.user = User.currentUser
        }
        
        hamburgerViewController.contentViewController = viewController
    }
}
