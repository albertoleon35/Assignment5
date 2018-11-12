//
//  RegisterStudentRepository.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class StudentRegistrationRepository {
    
    public func RegisterStudent(student: Student) throws -> Student {
        throw ErrorMessage.errorRegisteringStudent(error: ErrorDTO(errorMessage: "some error"))
    }
    
}
