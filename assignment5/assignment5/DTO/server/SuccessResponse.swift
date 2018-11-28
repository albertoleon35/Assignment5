//
//  Success.swift
//  assignment5
//
//  Created by Alberto Leon on 11/21/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import EVReflection

class SuccessResponse: EVObject {
    var ok: String?
    var error: String?
    
    required init() {
    }
}
