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
    var messageAlert = "";
    var success = false;
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let student = StudentDTO(firstName: firstNameTextBox.text, lastName: lastNameTextBox.text, redId: redIdTextBox.text, password: passwordTextBox.text, email: emailAddressTextBox.text);
        let studentService = StudentService(student: student)
        
        do {
            let validStudent = try studentService.isStudentValid()
            guard let studentToCreate = validStudent else {
                return;
            }
            createStudent(student: studentToCreate)
        } catch ErrorException.errorMessage(let error) {
            self.messageAlert = error.error!;
            showAlert()
        } catch {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showAlert() {
        self.success ? self.displayAlert() : self.displayAlert()
    }

    fileprivate func createStudent(student: Student) {
        
        do {
            let url = try Constants.getUrl(uri: self.uri)
            let data = try ObjectConverter().ConvertStudentToData(object: student)
            let gateway = Gateway(url: url, value: data)
            
            gateway.submitStudent() { successMessage, errorMessage in
                if let response = successMessage?.error {
                    self.messageAlert = "\(response)"
                    self.showAlert()
                    return;
                }
                self.success = true;
                self.messageAlert = "You have successfully registered"
                self.showAlert();
                
            }
        } catch ErrorException.errorMessage(let error) {
        } catch {
        }
    }
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "\(self.messageAlert)", message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toViewScheduleFromRegister", sender: nil)
        }))
        
        self.present(alert, animated: true)
    }
    
}
