//
//  ResultCollectionViewCell.swift
//  StyleShaker
//
//  Created by alexandre pouget on 04/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    //MARK : Properties
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    var product:Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
