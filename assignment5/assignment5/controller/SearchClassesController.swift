//
//  SearchClassesController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/24/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class SearchClassesViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var classTypePicker: UIPickerView!
    @IBOutlet weak var classesPicker: UIPickerView!
    @IBOutlet weak var classLevelPicker: UIPickerView!
    @IBOutlet weak var classStartTimePicker: UIPickerView!
    @IBOutlet weak var classEndTimePicker: UIPickerView!
    
    let uri = "subjectlist"
    let messageAlert = "Class start time should not be greater than class end time "
    let segueIdentifierName = "toFilteredClassesControllerFromFilterController"
    let subjects = ["Business Administration", "Engineering", "Science"]
    let classLevelArray = ["Lower Undergraduate (100 - 299)", "Upper Undergraduate (300 - 599)" ,"Graduate (500 - 899)"]
    let classTimeArray = ["0930", "1000", "1030", "1100", "1130", "1200", "1230", "1300", "1330", "1400", "1430", "1500", "1530", "1600", "1630", "1700", "1730","1800", "1830", "1900", "1930", "2000", "2030"]
    
    var subjectType = "Business Administration"
    var classLevel = "lower"
    var classStartTime = "0930"
    var classEndTime = "0930"
    var subjectDetail = SubjectDetailsResponse()
    var selectedItemsArray: [SubjectDetailsResponse] = []
    var classes = [SubjectDetailsResponse]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
        self.getSubjects()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if self.classStartTime >= self.classEndTime {
            self.displayAlert()
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == self.segueIdentifierName, let filteredClassViewController = segue.destination as? FilteredClassesViewController  {
                filteredClassViewController.classDetailDTO = ClassDetailDTO(subject: subjectDetail, level: classLevel, startTime: classStartTime, endTime: classEndTime)
                }
    }
    
    @IBAction func backFromFilteredView(segue: UIStoryboardSegue) {
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classTypePicker {
            return subjects.count
        } else if pickerView == classesPicker && selectedItemsArray.count > 0 {
            return selectedItemsArray.count
        } else if pickerView == classLevelPicker {
            return classLevelArray.count
        } else if pickerView == classStartTimePicker {
            return classTimeArray.count
        } else if pickerView == classEndTimePicker {
            return classTimeArray.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == classTypePicker {
            return subjects[row]
        } else if pickerView == classesPicker && selectedItemsArray.count > 0 {
            return selectedItemsArray[row].title
        } else if pickerView == classLevelPicker {
            return classLevelArray[row]
        } else if pickerView == classStartTimePicker {
            return classTimeArray[row]
        } else if pickerView == classEndTimePicker {
            return classTimeArray[row]
        }

        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == classTypePicker {
            switch row {
            case 0:
                setSelectSubjectArray(value: row)
            case 1:
                setSelectSubjectArray(value: row)
            case 2:
                setSelectSubjectArray(value: row)
            default:
                break;
            }
        }
        else if pickerView == classesPicker {
            subjectDetail = selectedItemsArray[row]
        }
        
        else if pickerView == classLevelPicker {
            classLevel = classLevelArray[row]
        }
        
        else if pickerView == classStartTimePicker {
            classStartTime = classTimeArray[row]
        }
        
        else if pickerView == classEndTimePicker {
            classEndTime = classTimeArray[row]
        }
        
        self.classesPicker.reloadAllComponents()
        self.classLevelPicker.reloadAllComponents()
        self.classStartTimePicker.reloadAllComponents()
    }
    
    fileprivate func setSelectSubjectArray(value: Int) {
        let classes = self.classes.filter{ $0.college == subjects[value]}
        selectedItemsArray = classes
        subjectDetail = selectedItemsArray.first ?? SubjectDetailsResponse()
        self.subjectType = subjects[value]
    }
    
    
    fileprivate func setupPickers() {
        self.classTypePicker.delegate = self
        self.classTypePicker.dataSource = self
        
        self.classesPicker.delegate = self
        self.classesPicker.dataSource = self
        
        self.classStartTimePicker.delegate = self
        self.classStartTimePicker.dataSource = self
        
        self.classLevelPicker.delegate = self
        self.classLevelPicker.dataSource = self
        
        self.classEndTimePicker.delegate = self
        self.classEndTimePicker.dataSource = self
    }
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "\(self.messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    fileprivate func getSubjects() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.uri))
            gateway.getClassesSubjectLists() { message in
                if let classes = message {
                    self.classes = classes;
                    self.selectedItemsArray = self.classes.filter{ $0.college == self.subjects[0]}
                    self.subjectDetail = self.selectedItemsArray.first ?? classes[1]
                    
                    self.classesPicker.reloadAllComponents()
                    self.classLevelPicker.reloadAllComponents()
                    self.classStartTimePicker.reloadAllComponents()
                }
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
}
