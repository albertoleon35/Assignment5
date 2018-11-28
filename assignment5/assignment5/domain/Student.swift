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
    
    public func ConvertStudentToData(object: Student) throws -> Data {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(object)
        
        guard let json = String(data: jsonData, encoding: String.Encoding.utf8) else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "Error serializing object"))
        }
        
        guard let data = json.data(using: .utf8) else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "some error"))
        }
        
        return data;
    }
}
