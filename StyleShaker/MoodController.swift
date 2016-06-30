//
//  MoodController.swift
//  StyleShaker
//
//  Created by alexandre pouget on 02/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit

class MoodController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var criteria:Criteria!
    var c:String = "";
    var moods = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.dataSource = self
        self.tableView?.delegate = self

        loadMood()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark : Implementation table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let this = moods[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("MoodTableViewCell",forIndexPath: indexPath) as! MoodTableViewCell
        cell.moodLabel.text = this
        
        return cell
    }
   
    
    //Mark : Action Button
    
    @IBAction func Valider(sender: AnyObject) {
        let moodCriteria:MoodCriteria = MoodCriteria()
        for i in 0 ..< moods.count {
            print("boucle ");
            let indexPath: NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
            let s:MoodTableViewCell = (self.tableView.cellForRowAtIndexPath(indexPath) as! MoodTableViewCell)
            print(s.moodLabel.text)
            
            if(s.moodLabel.text=="Travail"){
                print("Travail");
                moodCriteria.work = s.isActive
            }
            else if(s.moodLabel.text=="soiree"){
                print("soiree");
                moodCriteria.party = s.isActive
            }
            else if(s.moodLabel.text=="week-end"){
                print("week-end");
                moodCriteria.weekend = s.isActive
            }else if(s.moodLabel.text=="chill"){
                print("chill");
                moodCriteria.chill = s.isActive
            }
            self.criteria?.mood = moodCriteria
        }
        performSegueWithIdentifier("moodToResult", sender: criteria)
    }
    
    //Mark : MyFunction
    
    func loadMood(){
        moods += ["Travail","soiree","week-end","chill"]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="moodToResult"){
            let controller:ResultCollectionViewController = segue.destinationViewController as! ResultCollectionViewController
            controller.criteria = (sender as! Criteria)}
    }
    
    
}