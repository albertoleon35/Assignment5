//
//  StudentService.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class StudentService {
    
    let student: StudentDTO
    
    init(student: StudentDTO) {
        self.student = student
    }
    
    public func isStudentValid() throws -> Student? {
        
        guard let redid = self.student.redid, self.isRedIdValid(redId: redid.trimmingCharacters(in: .whitespaces)) else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "Red Id is invalid it should be 9 digits long"))
        }
        
        guard let password = self.student.password, isPasswordValid(password: password.trimmingCharacters(in: .whitespaces)) else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "Password should be at least 8 characters"))
        }
        
        guard let email = self.student.email, isEmailValid(email: email.trimmingCharacters(in: .whitespaces)) else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "Email is invalid"))
        }
        
        guard let firstName = student.firstname, let lastName = self.student.lastname else {
            return nil;
        }
        
        return Student(firstName: firstName, lastName: lastName, redId: redid, password: password, email: email);
    }
    
    fileprivate func isRedIdValid(redId: String) -> Bool {
        return redId.count == 9;
    }
    
    fileprivate func isPasswordValid(password: String) -> Bool {
        return password.count >= 8
    }
    
    fileprivate func isEmailValid(email: String) -> Bool {
        return email.contains("@");
    }
}
