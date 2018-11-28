//
//  ClassDetailViewController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/27/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class ClassDetailViewController: UIViewController {
    @IBOutlet weak var titleValue: UILabel!
    @IBOutlet weak var prequesitesValue: UILabel!
    @IBOutlet weak var seatsValue: UILabel!
    @IBOutlet weak var daysValue: UILabel!
    @IBOutlet weak var startTimeValue: UILabel!
    @IBOutlet weak var endTimeValue: UILabel!
    @IBOutlet weak var waitListValue: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var waitListButton: UIButton!
    @IBOutlet weak var unregisterButton: UIButton!
    @IBOutlet weak var unWaitlist: UIButton!
    
    var classDetail: ClassDetailsResponse? = ClassDetailsResponse()
    var flagSegue: String?
    var success = false
    let toClassDetailsFromClassDetailsTableView = "toClassDetailsFromClassDetailsTableView"
    let toClassDetailFromViewSchedule = "toClassDetailFromViewSchedule"
    var messageAlert = ""
    var successMessage = "Successfully added the class"
    var waitlistedMessage = "Succesfully waitlisted the class"
    
    var successMessageUnregisterClass = "Successfully unregistered the class"
    var unwaitlistedMessage = "Succesfully unwaitlisted the class"
    
    let registerclassUri = "registerclass"
    let waitListClassUri = "waitlistclass"
    let unwaitListClassUri = "unwaitlistclass"
    let unregisteredClassUri = "unregisterclass"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.enableButtons()
        self.popuplateData()
        
    }
    @IBAction func unwaitlistButtonPressed(_ sender: Any) {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: unwaitListClassUri))
            guard let details = classDetail, let student = AppState.student else {
                return
            }
            
            let addStudent = AddStudent(redid: student.redid, password: student.password, courseid: details.id )
            gateway.addStudentToClass(student: addStudent)  { response in
                if let message = response.error {
                    self.messageAlert = "\(message)"
                    self.displayAlert()
                    return;
                }
                self.success = true;
                self.messageAlert = self.unwaitlistedMessage
                self.displayAlert();
            }
        } catch  {
        }
    }
    
    @IBAction func waitListButtonPressed(_ sender: Any) {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: waitListClassUri))
            guard let details = classDetail, let student = AppState.student else {
                return
            }
            
            let addStudent = AddStudent(redid: student.redid, password: student.password, courseid: details.id )
            gateway.addStudentToClass(student: addStudent)  { response in
                if let message = response.error {
                    self.messageAlert = "\(message)"
                    self.displayAlert()
                    return;
                }
                self.success = true;
                self.messageAlert = self.waitlistedMessage
                self.displayAlert();
            }
        } catch  {
        }
    }
    @IBAction func unregisteredClassButtonPressed(_ sender: Any) {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.unregisteredClassUri))
            guard let details = classDetail, let student = AppState.student else {
                return
            }
            
            let addStudent = AddStudent(redid: student.redid, password: student.password, courseid: details.id )
            gateway.waitListStudent(student: addStudent)  { response in
                if let message = response.error {
                    self.messageAlert = "\(message)"
                    self.displayAlert()
                    return;
                }
                self.success = true;
                self.messageAlert = self.successMessageUnregisterClass
                self.displayAlert();
            }
        } catch  {
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.registerclassUri))
            guard let details = classDetail, let student = AppState.student else {
                return
            }

            let addStudent = AddStudent(redid: student.redid, password: student.password, courseid: details.id )
            gateway.waitListStudent(student: addStudent)  { response in
                if let message = response.error {
                    self.messageAlert = "\(message)"
                    self.displayAlert()
                    return;
                }
                self.success = true;
                self.messageAlert = self.successMessage
                self.displayAlert();
            }
        } catch  {
        }
    }
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "\(self.messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    fileprivate func enableButtons() {
        guard let details = classDetail, let flag = self.flagSegue else {
            return
        }
        if flag == self.toClassDetailsFromClassDetailsTableView {
            if details.seats == 1 {
                registerButton.isEnabled = false
                waitListButton.isEnabled = true
                return
            }
            unregisterButton.isEnabled = false
            unWaitlist.isEnabled = false
            unregisterButton.isHidden = true
            unWaitlist.isHidden = true
            
            waitListButton.isEnabled = false
        }
        else {
            registerButton.isEnabled = false
            waitListButton.isEnabled = false
            registerButton.isHidden = true
            waitListButton.isHidden = true
        }
       
    }
    
    fileprivate func popuplateData() {
        guard let details = classDetail else {
            return
        }
        
        titleValue.text = details.fullTitle
        titleValue.isHidden = false
        
        prequesitesValue.text = details.prerequisite
        prequesitesValue.isHidden = false
        
        seatsValue.text = details.seats == 1 ? "" : String(details.seats)
        seatsValue.isHidden = false
        
        daysValue.text = details.days
        daysValue.isHidden = false
        
        startTimeValue.text = details.startTime
        startTimeValue.isHidden = false
        
        endTimeValue.text = details.endTime
        endTimeValue.isHidden = false
        
        waitListValue.text = String(details.waitlist)
        waitListValue.isHidden = false
        
        
    }
    
}
