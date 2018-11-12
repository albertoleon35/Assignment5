//
//  StudentRegistrationService.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class StudentRegistrationService {
    
    public func registerStudent(student: Student) -> Student? {
        do {
            let repository = StudentRegistrationRepository();
            return try repository.RegisterStudent(student: student);
        } catch ErrorMessage.errorRegisteringStudent(let error) {
            print("Error: \(error.error)")
        }
        catch {
            print("who knows what happened")
        }
        return nil;
    }
}
