//
//  ErrorMessage.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
    case errorRegisteringStudent(error: ErrorDTO);
}
