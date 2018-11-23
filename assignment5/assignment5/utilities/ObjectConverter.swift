//
//  RegisterStudentRepository.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation


class ObjectConverter {
    
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
