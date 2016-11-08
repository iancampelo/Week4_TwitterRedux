//
//  MenuCell.swift
//  Week4_Twitter
//
//  Created by Ian Campelo on 11/8/16.
//  Copyright © 2016 Ian Campelo. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuItemLabel: UILabel!
    @IBOutlet weak var menuIconImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
