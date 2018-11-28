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
        self.getSubjects(completionHandler: completionHandler)
    }
    
    public func getClassIdsLists(classDetail: Subject, completionHandler: @escaping ([Int]) -> ()) {
        self.getClassesIds(classDetail: classDetail, completionHandler: completionHandler);
    }
    
    public func getClassDetails(classIds: ClassIds, completionHandler: @escaping ([ClassDetailsResponse]) -> ()) {
        self.getClassesDetails(classIds: classIds, completionHandler: completionHandler)
    }
    
    public func getStudentClasses(student: ClassStudentDTO, completionHandler: @escaping (StudentClasses) -> ()) {
        self.getStudentClassSchedule(student: student, completionHandler: completionHandler)
    }
    
    public func addStudentToClass(student: AddStudent, completionHandler: @escaping (SuccessResponse) -> ()) {
        self.postStudentToClass(student: student, completionHandler: completionHandler)
    }
    
    public func unregisteredStudent(student: AddStudent, completionHandler: @escaping (SuccessResponse) -> ()) {
        self.postStudentToClass(student: student, completionHandler: completionHandler)
    }
    
    public func unwaitListStudent(student: AddStudent, completionHandler: @escaping (SuccessResponse) -> ()) {
        self.postStudentToClass(student: student, completionHandler: completionHandler)
    }
    
    public func waitListStudent(student: AddStudent, completionHandler: @escaping (SuccessResponse) -> ()) {
        self.postStudentToClass(student: student, completionHandler: completionHandler)
    }
    
    fileprivate func getStudentClassSchedule(student: ClassStudentDTO, completionHandler: @escaping  (StudentClasses) -> ()) {
        var otherRequest = URLRequest(url: self.url)
        otherRequest.httpMethod = HTTPMethod.post.rawValue
        do {
            otherRequest.httpBody = try student.ConvertToData(object: student)
        } catch { }
        
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(otherRequest).validate(statusCode: 200..<300).responseString { response in
            if let result = response.result.value {
                print(result)
                completionHandler(StudentClasses(json: result))
            }
        }
    }
    
    fileprivate func postStudentToClass(student: AddStudent, completionHandler: @escaping  (SuccessResponse) -> ()) {
        var otherRequest = URLRequest(url: self.url)
        otherRequest.httpMethod = HTTPMethod.post.rawValue
        do {
            otherRequest.httpBody = try student.ConvertToData(object: student)
        } catch { }
        
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(otherRequest).validate(statusCode: 200..<300).responseObject { (response: DataResponse<SuccessResponse>) in
        if let result = response.result.value {
            completionHandler(result)
            }
        }
    }
    
    fileprivate func getClassesDetails(classIds: ClassIds, completionHandler: @escaping  ([ClassDetailsResponse]) -> ()) {
        
        var otherRequest = URLRequest(url: self.url)
        otherRequest.httpMethod = HTTPMethod.post.rawValue
        do {
            otherRequest.httpBody = try classIds.ConvertToData(object: classIds)
        } catch { }
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(otherRequest).validate(statusCode: 200..<300).responseString { response in
            if let result = response.result.value {
                completionHandler([ClassDetailsResponse](json: result))
            }
        }
    }
    
    fileprivate func getClassesIds(classDetail: Subject, completionHandler: @escaping  ([Int]) -> ()) {
        var otherRequest = URLRequest(url: self.url)
        otherRequest.httpMethod = HTTPMethod.post.rawValue
        
        do {
           otherRequest.httpBody = try classDetail.ConvertToData(object: classDetail)
        } catch { }
       
        otherRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(otherRequest).validate(statusCode: 200..<300).responseJSON { (response: DataResponse<Any>) in
            if let result = response.result.value {
                guard let classIds = result as? [Int] else {
                    return;
                }
                completionHandler(classIds)
            }
        }
    }
    
    fileprivate func getSubjects(completionHandler: @escaping ([SubjectDetailsResponse]?) -> ()) {
        
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
