//
//  DataBackDelegate.swift
//  assignment5
//
//  Created by Alberto Leon on 11/27/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

protocol DataBackDelegate: class {
    func savePreferences (classesDetails : [ClassDetailsResponse])
}
