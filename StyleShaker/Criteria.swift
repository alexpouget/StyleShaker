//
//  Criteria.swift
//  StyleShaker
//
//  Created by alexandre pouget on 19/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation

class Criteria {
    var mood:MoodCriteria?
    var gender:Gender?
    var hair:Hair?
    var skin:Skin?
    
    init(){
        
    }
    
    init(mood : MoodCriteria,gender : Gender,hair : Hair,skin:Skin){
        self.mood = mood
        self.gender = gender
        self.hair = hair
        self.skin = skin
    }
    
}