//
//  Constants.swift
//  assignment5
//
//  Created by Alberto Leon on 11/20/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation

class Constants {
    public static let bismarck = "https://bismarck.sdsu.edu/registration/"
    
    public static func getUrl(uri: String) throws -> URL {
        guard let url = URL(string: "\(Constants.bismarck)\(uri)") else {
            throw ErrorException.errorMessage(error: ErrorMessage(errorMessage: "Malformed URL"))
        }
        
        return url
    }
}

