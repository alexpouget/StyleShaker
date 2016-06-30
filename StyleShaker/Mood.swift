//
//  Mood.swift
//  StyleShaker
//
//  Created by alexandre pouget on 03/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation

class Mood {
    var name:String = ""
    var right:String = ""
    var left:String = ""
    
    init(name : String,right : String,left : String){
        self.name = name
        self.right = right
        self.left = left
    }
}