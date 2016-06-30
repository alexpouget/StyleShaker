//
//  ResultCollectionViewController.swift
//  StyleShaker
//
//  Created by alexandre pouget on 04/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"
let url: NSURL = NSURL(string: "http://163.172.27.134/api/products")!
let userDefaults = NSUserDefaults.standardUserDefaults()

class ResultCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var products: [Product] = []
    var criteria:Criteria? = nil
    
    override func viewDidLoad() {
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            if(Connectivity.hasConnectivity()){
                print("connected");
            userDefaults.setObject(data, forKey: "data")
            }
            let myData = userDefaults.objectForKey("data")
            self.parseJson(myData as! NSData)
        }
        task.resume()
        
        print(self.products.count)
        
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
    }
    
    func parseJson(data : NSData){
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            for item in json as! [[String: AnyObject]] {
                let product: Product = Product(title: item["title"] as! String,picture: item["picture"] as! String,thumbnail: item["thumbnail"] as! String,about: item["about"] as! String,id: item["id"] as! String,tags : item["tags"] as! Array)
                let new_criteria:Criteria = Criteria()
                let crit = item["criteria"]! as! NSDictionary
                let mood = crit["mood"] as! [String: AnyObject]
                new_criteria.mood = MoodCriteria(party: (mood["party"] as? Bool)!,weekend: (mood["weekend"] as? Bool)!,chill: (mood["chill"] as? Bool)!,work: (mood["work"] as? Bool)!)
                let gender = crit["gender"] as! [String: AnyObject]
                new_criteria.gender = Gender(female :(gender["female"] as?Bool)!,male :(gender["male"] as?Bool)!)
                let hair = crit["hair"] as! [String: AnyObject]
                new_criteria.hair = Hair(dark: (hair["dark"] as?Bool)!, bright: (hair["bright"] as?Bool)!)
                let skin = crit["skin"] as! [String: AnyObject]
                new_criteria.skin = Skin(dark: (skin["dark"] as?Bool)!, bright: (skin["bright"] as?Bool)!)
                product.criteria = new_criteria
                if(self.compare(self.criteria!,c2 : product.criteria!)){
                    self.products.append(product);
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.collectionView.reloadData()
            })
        }
        catch {
            print("Error during serialization");
        }

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if(products.count < 10){
            return products.count
        }
        return 10
    }
    var i:Int = 0

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ResultCollectionViewCell", forIndexPath: indexPath) as! ResultCollectionViewCell
        cell.layer.cornerRadius = 2
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.blackColor().CGColor
        var rand:Int = 0
        if(products.count>i){
            if products.count>=10 {
                rand = Int(arc4random_uniform(10))
            }else{
                rand = Int(arc4random_uniform(UInt32(products.count)))
                print("rand : ",rand , " count : ",products.count)
            }
            cell.product = products[rand]
            let array = products[rand].title!.characters.split{$0 == " "}.map(String.init)
            cell.lbl.text = array[0]
            let url = NSURL(string:products[rand].thumbnail!)
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                cell.image.image = UIImage(data:data!)
            }
            products.removeAtIndex(rand)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell =  collectionView.cellForItemAtIndexPath(indexPath) as! ResultCollectionViewCell
        print("perform segue ")
        print(cell.lbl.text!)
        performSegueWithIdentifier("resultToDescription", sender: cell.product)
        
    }

    // MARK: UICollectionViewDelegate

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare for segue")
       // print((sender as! Product).title)
        if(segue.identifier=="resultToDescription"){
            let controller:DescriptionViewController = segue.destinationViewController as! DescriptionViewController
            controller.product = (sender as! Product)}
    }
    
    
    //MARK: Shake detection
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            if products.count<=0 {
                let alertView = UIAlertView(title: "Error", message: "Il n'y a plus d'autres produits selon vos criteres", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Reçu !")
                alertView.show()
            }else{
                self.collectionView.reloadData()
                print("shake change produit")
            }
        }
    }
    
    
    //MARK: Comparaison
    
    func compare(c : Criteria,c2 : Criteria) -> Bool {
        if(c.gender?.female == true || c.gender?.male == true){
            if(c.gender?.female != c2.gender?.female){
                return false;
            }
            if(c.gender?.male != c2.gender?.male){
                return false;
            }
        }
        
        if(c.skin?.bright == true || c.skin?.dark == true){
            if(c.skin?.bright != c2.skin?.bright){
                return false;
            }
            if(c.skin?.dark != c2.skin?.dark){
                return false;
            }
        }
        if(c.hair?.bright == true || c.hair?.dark == true){
            if(c.hair?.bright != c2.hair?.bright){
                return false;
            }
            if(c.hair?.dark != c2.hair?.dark){
                return false;
            }
        }
        if(c.mood?.chill == true){
            if(c.mood?.chill == c2.mood?.chill){
                return true;
            }
        }
        if(c.mood?.work == true){
            if(c.mood?.work != c2.mood?.work){
                return true;
            }
        }
        if(c.mood?.weekend == true){
            if(c.mood?.weekend != c2.mood?.weekend){
                return true;
            }
        }
        if(c.mood?.party == true){
            if(c.mood?.party != c2.mood?.party){
                return true;
            }
        }
        if(c.mood?.party != true && c.mood?.weekend != true && c.mood?.work != true && c.mood?.chill != true){
            return true
        }
        return false
    }
    
    /*func hasConnectivity() -> Bool {
        let reachability:Reachability = Reachability.reachabilityForInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }*/
    
    

}
