//
//  Student.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class Student : Codable {
    
    let firstname: String;
    let lastname: String;
    let redid: String;
    let password: String;
    let email: String;
    
    init(firstName: String, lastName: String, redId: String, password: String, email: String) {
        self.firstname = firstName;
        self.lastname = lastName;
        self.redid = redId;
        self.password = password;
        self.email = email;
    }
}
