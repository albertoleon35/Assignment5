//
//  RegisterController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var firstNameTextBox: UITextField!
    @IBOutlet weak var lastNameTextBox: UITextField!
    @IBOutlet weak var redIdTextBox: UITextField!
    @IBOutlet weak var emailAddressTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    let uri = "addstudent"
    let redIdEquals = "Red Id already in use"
    let alreadyRegistered = "Red Id is already registered. We are taking to search classes."
    let successMessage = "You have successfully registered"
    let scheduleMessage = "Retreieving class schedule"
    let toViewScheduleFromRegisterId = "toViewScheduleFromRegister"
    let toSearchClassesFromRegister = "toSearchClassesFromRegister"
    
    var messageAlert = ""
    var success = false
    var createdStudent: Student?
    
    @IBAction func viewScheduleButtonPressed(_ sender: Any) {
        let student = StudentDTO(firstName: firstNameTextBox.text, lastName: lastNameTextBox.text, redId: redIdTextBox.text, password: passwordTextBox.text, email: emailAddressTextBox.text);
        let studentService = StudentService(student: student)
        
        do {
            let validStudent = try studentService.isStudentValid()
            guard let studentToLookSchedule = validStudent else {
                return;
            }
            self.success = true;
            self.messageAlert = self.scheduleMessage
            AppState.student = studentToLookSchedule
            showAlert(identifier: self.toViewScheduleFromRegisterId)
            
        } catch ErrorException.errorMessage(let error) {
            self.messageAlert = error.error!
            showAlert(identifier: self.toViewScheduleFromRegisterId)
        } catch {
            
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let student = StudentDTO(firstName: firstNameTextBox.text, lastName: lastNameTextBox.text, redId: redIdTextBox.text, password: passwordTextBox.text, email: emailAddressTextBox.text);
        let studentService = StudentService(student: student)
        
        do {
            let validStudent = try studentService.isStudentValid()
            guard let studentToCreate = validStudent else {
                return;
            }
            self.createStudent(student: studentToCreate)
        } catch ErrorException.errorMessage(let error) {
            guard let errorMessage = error.error else {
                return;
            }
        
            self.messageAlert = errorMessage
            showAlert(identifier: self.toViewScheduleFromRegisterId)
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.toViewScheduleFromRegisterId {
            
        }
    }
    
    fileprivate func createStudent(student: Student) {
        
        do {
            let url = try Constants.getUrl(uri: self.uri)
            let data = try student.ConvertStudentToData(object: student)
            let gateway = Gateway(url: url, value: data)
            
            gateway.submitStudent() { message in
                if let response = message?.error {
                    
                    if response.lowercased() == self.redIdEquals.lowercased() {
                        self.success = true;
                        self.messageAlert = self.alreadyRegistered
                        self.showAlert(identifier: self.toSearchClassesFromRegister)
                        AppState.student = student
                    }
                    self.messageAlert = "\(response)"
                    self.showAlert(identifier: self.toSearchClassesFromRegister)
                    return;
                }
                else {
                    self.success = true;
                    self.messageAlert = self.successMessage
                    self.createdStudent = student
                    AppState.student = student
                    self.showAlert(identifier: self.toSearchClassesFromRegister);
                }
                
                
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
    
    fileprivate func showAlert(identifier: String) {
        let alert = UIAlertController(title: "\(self.messageAlert)", message: "", preferredStyle: .alert)
        
        success ? alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.performSegue(withIdentifier: identifier, sender: nil)
        })) : alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
}
