//
//  Product.swift
//  StyleShaker
//
//  Created by alexandre pouget on 19/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation

class Product {
    var title:String?
    var picture:String?
    var thumbnail:String?
    var about:String?
    var id:String?
    var criteria:Criteria?
    var tags:Array<String>?
    
    init(){
        
    }
    
    init(title : String,picture : String,thumbnail : String,about : String,id : String,criteria : Criteria){
        self.title = title
        self.picture = picture
        self.thumbnail = thumbnail
        self.about = about
        self.id = id
        self.criteria = criteria
    }
    init(title : String,picture : String,thumbnail : String,about : String,id : String,tags : Array<String>){
        self.title = title
        self.picture = picture
        self.thumbnail = thumbnail
        self.about = about
        self.id = id
        self.tags = tags
    }
    init(title : String,picture : String,thumbnail : String,about : String,id : String){
        self.title = title
        self.picture = picture
        self.thumbnail = thumbnail
        self.about = about
        self.id = id
    }
    
}