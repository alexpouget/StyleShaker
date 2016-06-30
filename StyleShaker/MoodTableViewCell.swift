//
//  MoodTableViewCell.swift
//  StyleShaker
//
//  Created by alexandre pouget on 03/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    //Mark : Properties
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    let userDefaults = NSUserDefaults.standardUserDefaults()
  
    var isActive = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.isActive = userDefaults.boolForKey("isActive"+moodLabel.text!)
        if isActive{
            mySwitch.setOn(true, animated: true)
        }
        // Configure the view for the selected state
    }
    
    
    @IBAction func isActive(sender: AnyObject) {
        print("change")
        self.isActive = self.isActive ? false : true
        userDefaults.setBool(self.isActive, forKey:"isActive"+moodLabel.text!)
    }

}
