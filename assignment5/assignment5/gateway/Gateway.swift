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
    let value: Data?
    
    init (url: URL, value: Data) {
        self.url = url
        self.value = value
    }
    
    init (url: URL) {
        self.url = url
        self.value = nil
    }

    public func submitStudent(completionHandler: @escaping (SuccessResponse?) -> ()) {
        self.createStudent(completionHandler: completionHandler)
    }
    
    public func getClassesSubjectLists(completionHandler: @escaping ([SubjectDetailsResponse]?) -> ()) {
        self.getClasses(completionHandler: completionHandler)
    }
    
    fileprivate func getClasses(completionHandler: @escaping ([SubjectDetailsResponse]?) -> ()) {
        
        var otherRequest = URLRequest(url: self.url)
        otherRequest.httpMethod = HTTPMethod.get.rawValue
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        Alamofire.request(otherRequest).validate(statusCode: 200..<300).responseString { response in
            
            if let result = response.result.value {
                completionHandler([SubjectDetailsResponse](json: result))
            }
        }
    }
    
    fileprivate func createStudent(completionHandler: @escaping (SuccessResponse?) -> ()) {
       
        var request = URLRequest(url: self.url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = self.value
        
        Alamofire.request(request).validate(statusCode: 200..<300).responseObject { (response: DataResponse<SuccessResponse>) in
            if let result = response.result.value {
                completionHandler(result)
            }
        }
    }
}
