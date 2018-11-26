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
    let time: String
    
    init(subject: SubjectDetailsResponse, level: String, time: String) {
        self.classResponse = subject
        self.level = level
        self.time = time
    }
    
}
