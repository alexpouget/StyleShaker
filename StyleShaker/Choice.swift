//
//  Choice.swift
//  StyleShaker
//
//  Created by alexandre pouget on 02/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation

class Choice {
    var name:String = ""
    var right:String = ""
    var left:String = ""
    
    init(){
        
    }
    
    init(name : String,right : String,left : String){
        self.name = name
        self.right = right
        self.left = left
    }
}
