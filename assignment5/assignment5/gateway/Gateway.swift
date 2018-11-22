//
//  Gateway.swift
//  assignment5
//
//  Created by Alberto Leon on 11/14/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Gateway {
    
    let url: URL
    let value: Data
    
    init (url: URL, value: Data) {
        self.url = url
        self.value = value
    }
    
    public func submitStudent(completionHandler: @escaping (Any, Error?) -> ()) {
        self.post(completionHandler: completionHandler)
    }
    
    fileprivate func post(completionHandler: @escaping (Any, Error?) -> ()) {
       
        var request = URLRequest(url: self.url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = self.value
        
        Alamofire.request(request).responseJSON { (response) in
            guard let value = response.value as? Any else {
                return;
            }
            print(response.result)
            print(response.response?.statusCode)
            print(response.response.debugDescription)
            completionHandler(value, nil)
        }
    }
}
