//
//  ClassDetailDTO.swift
//  assignment5
//
//  Created by Alberto Leon on 11/25/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class ClassDetailDTO {
    let classResponse: SubjectDetailsResponse
    let level: String
    let startTime: String
    let endTime: String
    
    fileprivate let levelDictionary: Dictionary<String, String> = ["Lower Undergraduate (100 - 299)":"lower","Upper Undergraduate (300 - 599)":"upper","Graduate (500 - 899)":"graduate"]
    
    init(subject: SubjectDetailsResponse, level: String, startTime: String, endTime: String) {
        self.classResponse = subject
        self.level = level
        self.startTime = startTime
        self.endTime = endTime
    }
    
    public func levelAdapter() -> String {
        return self.levelDictionary[self.level] ?? "lower";
    }
}
