//
//  ClassDetails.swift
//  assignment5
//
//  Created by Alberto Leon on 11/26/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import Foundation
import EVReflection

class ClassDetailsResponse: EVObject {
    
    var _description: String = ""
    var department: String = ""
    var suffix: String = ""
    var building: String = ""
    var startTime: String = ""
    var meetingType: String = ""
    var section: String = ""
    var endTime: String = ""
    var enrolled: Int = 0
    var days: String = ""
    var prerequisite: String = ""
    var title: String = ""
    var id: Int = 0
    var instructor: String = ""
    var schedule: String = ""
    var units: String = ""
    var room: String = ""
    var waitlist:Int = 0
    var seats: Int = 0
    var fullTitle:String = ""
    var subject: String = ""
    var course: String = ""
    
    required init() {
    }
    
    init(_description: String, department: String, suffix: String, building: String, startTime: String, meetingType: String, section: String, endTime: String, enrolled: Int, days: String, prerequisite: String, title: String, id: Int, instructor: String, schedule: String, units: String, room: String, waitlist: Int, seats: Int, fullTitle: String, subject: String, course: String) {
        self._description = _description
        self.department = department
        self.suffix = suffix
        self.building = building
        self.startTime = startTime
        self.meetingType = meetingType
        self.section = section
        self.endTime = endTime
        self.enrolled = enrolled
        self.days = days
        self.prerequisite = prerequisite
        self.title = title
        self.id = id
        self.instructor = instructor
        self.schedule = schedule
        self.units = units
        self.room = room
        self.waitlist = waitlist
        self.seats = seats
        self.fullTitle = fullTitle
        self.subject = subject
        self.course = course
    }
}
