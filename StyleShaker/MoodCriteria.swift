//
//  MoodCriteria.swift
//  StyleShaker
//
//  Created by alexandre pouget on 19/06/2016.
//  Copyright © 2016 alexandre pouget. All rights reserved.
//

import Foundation

class MoodCriteria {
    var party:Bool = false
    var weekend:Bool = false
    var chill:Bool = false
    var work:Bool = false
    
    init(){
        
    }
    
    init(party :Bool,weekend :Bool,chill :Bool,work :Bool){
        self.party = party
        self.weekend = weekend
        self.chill = chill
        self.work = work
        
    }
}