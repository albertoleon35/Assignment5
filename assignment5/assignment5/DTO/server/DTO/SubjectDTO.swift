//
//  SubjectDTO.swift
//  assignment5
//
//  Created by Alberto Leon on 11/26/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import EVReflection

class Subject: EVObject, Encodable {
    var subjectids: [Int]?
    var level : String?
    var starttime: String?
    var endtime: String?
    
    required init() {
    }
    
    init(subjectids: [Int]?, level: String?, starttime: String?, endtime: String? ) {
        self.subjectids = subjectids
        self.level = level
        self.starttime = starttime
        self.endtime = endtime
    }
    
    public func ConvertToData(object: Subject) throws -> Data {
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
