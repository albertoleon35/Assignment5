//
//  StudentClasses.swift
//  assignment5
//
//  Created by Alberto Leon on 11/27/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import EVReflection

class StudentClasses: EVObject {
    var classes = [Int]()
    var waitlist = [Int]()
    
    required init() {
    }
    
    init(classes: [Int], waitlist: [Int]) {
        self.classes = classes
        self.waitlist = waitlist
    }
}
