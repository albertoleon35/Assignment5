//
//  ErrorDTO.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import EVReflection

class ErrorMessage : EVObject {
    var error: String?
    
    init(errorMessage: String) {
        self.error = errorMessage
    }
    
    required init() {
    }
}
