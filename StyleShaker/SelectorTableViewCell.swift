//
//  SelectorTableViewCell.swift
//  StyleShaker
//
//  Created by alexandre pouget on 02/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit


class SelectorTableViewCell: UITableViewCell {
    
    
    //MARK : Properties
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var mySwitch: UISwitch!
    
    var right = false
    var left = false
    var isActive = true
    let userDefaults = NSUserDefaults.standardUserDefaults()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if label.text! != "Label" {
            print("right"+label.text!)
            self.left = userDefaults.boolForKey("left"+label.text!)
            self.right = userDefaults.boolForKey("right"+label.text!)
            self.isActive = userDefaults.boolForKey("isActive"+label.text!)
            if(self.left){
                leftAction(self)
            }else if(self.right){
                rightAction(self)
            }
            if self.isActive {
                self.mySwitch.setOn(true, animated: true)
            }else{
                self.mySwitch.setOn(false, animated: true)
            }
            
        }
        // Configure the view for the selected state
    }
    
    //MARK : Actions
    @IBAction func rightAction(sender: AnyObject) {
        if(isActive){
            rightButton.layer.cornerRadius = 2
            rightButton.layer.borderWidth = 1
            rightButton.layer.borderColor = UIColor.blackColor().CGColor
            leftButton.layer.borderWidth = 0
            self.right = true
            self.left = false
            userDefaults.setBool(self.right, forKey: "right"+label.text!)
            userDefaults.setBool(self.left, forKey: "left"+label.text!)
        }
    }
    @IBAction func leftAction(sender: AnyObject) {
        if(isActive){
            leftButton.layer.cornerRadius = 2
            leftButton.layer.borderWidth = 1
            leftButton.layer.borderColor = UIColor.blackColor().CGColor
            
            rightButton.layer.borderWidth = 0
            self.right = false
            self.left = true
            print("right"+label.text!)
            userDefaults.setBool(self.right, forKey: "right"+label.text!)
            userDefaults.setBool(self.left, forKey: "left"+label.text!)
        }
    }
    @IBAction func isActive(sender: AnyObject) {
        self.isActive = self.isActive ? false : true
        userDefaults.setBool(self.isActive, forKey:"isActive"+label.text!)
        if self.isActive == false {
            self.right = false
            self.left = false
            rightButton.layer.borderWidth = 0
            leftButton.layer.borderWidth = 0
            userDefaults.setBool(self.right, forKey: "right"+label.text!)
            userDefaults.setBool(self.left, forKey: "left"+label.text!)
        }

    }

}
