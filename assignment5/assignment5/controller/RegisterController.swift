//
//  RegisterController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/11/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextBox: UITextField!
    @IBOutlet weak var lastNameTextBox: UITextField!
    @IBOutlet weak var redIdTextBox: UITextField!
    @IBOutlet weak var emailAddressTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    let uri = "addstudent"
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        let student = StudentDTO(firstName: firstNameTextBox.text, lastName: lastNameTextBox.text, redId: redIdTextBox.text, password: passwordTextBox.text, email: emailAddressTextBox.text);
        let studentService = StudentService(student: student)
        
        guard let validStudent = studentService.isStudentValid() else {
            print("something wrong with student")
            return;
        }
        
        
        guard let url = URL(string: "\(Constants.bismarck)\(self.uri)") else {
            return;
        }
        
        do {
            let data = try ObjectConverter().ConvertToData(object: validStudent)
            let gateway = Gateway(url: url, value: data)
            
            gateway.submitStudent() { responseObject, error in
                print("\(responseObject)")
                print("\(error)")
            }
        } catch ErrorMessage.errorRegisteringStudent(let error) {
            print("Error: \(error.error)")
        } catch {
            print("error")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
