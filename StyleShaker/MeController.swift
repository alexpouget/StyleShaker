//
//  MeController.swift
//  StyleShaker
//
//  Created by alexandre pouget on 02/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//


import UIKit

class MeController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //Mark : Properties
    var criteria:Criteria = Criteria()
    var meChoice = [Choice]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        loadChoice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark : TableImplementation
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meChoice.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let choice = meChoice[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectorTableViewCell",forIndexPath: indexPath) as! SelectorTableViewCell
        cell.label.text = choice.name
        cell.leftButton.setTitle(choice.left, forState: .Normal)
        cell.rightButton.setTitle(choice.right, forState: .Normal)
        return cell
    }
    
    //Mark : Action Button
    @IBAction func Valider(sender: AnyObject) {
        print("valider");
        var flag:Bool = true;
        for i in 0 ..< meChoice.count {
            print("boucle ");
            let indexPath: NSIndexPath = NSIndexPath(forRow: i, inSection: 0)
            var s:SelectorTableViewCell = (self.tableView.cellForRowAtIndexPath(indexPath) as! SelectorTableViewCell)
            print(s.label.text)
            if(s.label.text=="peau"){
                if(!s.left && !s.right  && s.isActive){
                    flag = false;
                }
                print("peau");
                self.criteria.skin = Skin(dark: s.right,bright: s.left)
            }
            else if(s.label.text=="cheveux"){
                if(!s.left && !s.right && s.isActive){
                    flag = false;
                }
                print("cheveux");
                self.criteria.hair = Hair(dark: s.left, bright: s.right)
            }
            else if(s.label.text=="Sexe"){
                if(!s.left && !s.right  && s.isActive){
                    flag = false;
                }
                print("Sexe");
                self.criteria.gender = Gender(female: s.right,male: s.left)
            }
        }
        if(flag){
        performSegueWithIdentifier("meToMood", sender: criteria)
        }else{
            let alertView = UIAlertView(title: "Error", message: "veuillez faire un choix pour chaque critère activé ", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Reçu !")
            alertView.show()
        }
    }
    
    @IBAction func Apropos(sender: AnyObject) {
        performSegueWithIdentifier("meToAPropos", sender: self)
    }
    
    //Mark : MyFunc
    
    func loadChoice(){
        let choice1 = Choice(name: "peau", right: "fonce", left: "clair")
        let choice2 = Choice(name: "cheveux", right: "fonce", left: "clair")
        let choice3 = Choice(name: "Sexe", right: "femelle", left: "male")
        meChoice += [choice1, choice2,choice3]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="meToMood"){
            let controller:MoodController = segue.destinationViewController as! MoodController
            controller.criteria = (sender as! Criteria)}
    }
    
    
    
}