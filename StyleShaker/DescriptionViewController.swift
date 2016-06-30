//
//  DescriptionViewController.swift
//  StyleShaker
//
//  Created by alexandre pouget on 19/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var product:Product? = nil
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titre: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(product != nil){
            titre.text = product!.title
            for s in product!.tags!{
                let label = UILabel(frame: CGRectMake(0, 0, 300, 21))
                label.backgroundColor = UIColor.blueColor()
                label.center = CGPointMake(150, 280)
                label.textAlignment = NSTextAlignment.Left
                label.text = s
                self.view.addSubview(label)
            }
            textView.text = product!.about
            let u:String? = product!.picture
            print(u)
            let url = NSURL(string:u!)
            let data = NSData(contentsOfURL:url!)
            if data != nil {
                image.image = UIImage(data:data!)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="descriptionToWeb"){
            let controller:WebViewController = segue.destinationViewController as! WebViewController
            controller.t = product?.title
        }
    }
 
    @IBAction func goWeb(sender: AnyObject) {
        if Connectivity.hasConnectivity() {
            performSegueWithIdentifier("descriptionToWeb", sender: nil)
        }else{
            let alertView = UIAlertView(title: "Error", message: "Vous ne pouvez pas allez sur google shopping car vous n'etes pas connecté", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Reçu !")
            alertView.show()
        }
        
    }

}
