//
//  Gateway.swift
//  assignment5
//
//  Created by Alberto Leon on 11/14/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import Alamofire


class Gateway {
    
    let url: URL
    let value: Data
    
    init (url: URL, value: Data) {
        self.url = url
        self.value = value
    }
    
    public func submitStudent(completionHandler: @escaping (SuccessResponse?, ErrorMessage?) -> ()) {
        self.post(completionHandler: completionHandler)
    }
    
    fileprivate func post(completionHandler: @escaping (SuccessResponse?, ErrorMessage?) -> ()) {
       
        var request = URLRequest(url: self.url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = self.value
        
        Alamofire.request(request).validate(statusCode: 200..<300).responseObject { (response: DataResponse<SuccessResponse>) in
            if let result = response.result.value {
                completionHandler(result, nil)
            }
        }
    }
}
