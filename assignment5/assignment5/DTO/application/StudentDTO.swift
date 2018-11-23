//
//  StudentDTO.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class StudentDTO {
    
    var firstname: String?;
    var lastname: String?;
    var redid: String?;
    var password: String?;
    var email: String?;
    
    init(firstName: String?, lastName: String?, redId: String?, password: String?, email: String?) {
        self.firstname = firstName;
        self.lastname = lastName;
        self.redid = redId;
        self.password = password;
        self.email = email;
    }
}
