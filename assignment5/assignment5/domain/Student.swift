//
//  Student.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class Student {
    
    let firstName: String;
    let lastName: String;
    let redId: Int;
    let password: String;
    let email: String;
    
    init(firstName: String, lastName: String, redId: Int, password: String, email: String) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.redId = redId;
        self.password = password;
        self.email = email;
    }
}
