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
    @IBOutlet weak var classTimePicker: UIPickerView!
    
    let uri = "subjectlist"
    let colleges = ["Business Administration", "Engineering", "Science"]
    let classLevel = ["Lower Undergraduate (100 - 299)", "Upper Undergraduate (300 - 599)" ,"Graduate (500 - 899)"]
    let classTime = ["0930", "1000", "1030", "1100", "1130", "1200", "1230", "1300", "1330", "1400", "1430", "1500", "1530", "1600", "1630", "1700", "1730","1800", "1830", "1900", "1930", "2000", "2030"]
    
    var classType = ""
    var selectedItemsArray: [SubjectDetailsResponse] = []
    var classes = [SubjectDetailsResponse]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickers()
        
        
        self.getClasses()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == classTypePicker {
            return colleges.count
        } else if pickerView == classesPicker && selectedItemsArray.count > 0 {
            return selectedItemsArray.count
        } else if pickerView == classLevelPicker {
            return classLevel.count
        } else if pickerView == classTimePicker {
            return classTime.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == classTypePicker {
            return colleges[row]
        } else if pickerView == classesPicker && selectedItemsArray.count > 0 {
            return selectedItemsArray[row].title
        } else if pickerView == classLevelPicker {
            return classLevel[row]
        } else if pickerView == classTimePicker {
            return classTime[row]
        }
        
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == classTypePicker {
            switch row {
            case 0:
                let classes = self.classes.filter{ $0.college == colleges[0]}
                selectedItemsArray = classes
                self.classType = colleges[0]
            case 1:
                let classes = self.classes.filter{ $0.college == colleges[1]}
                selectedItemsArray = classes
                self.classType = colleges[1]
            case 2:
                let classes = self.classes.filter{ $0.college == colleges[2]}
                selectedItemsArray = classes
                self.classType = colleges[2]
            default:
                break;
            }
            self.classesPicker.reloadAllComponents()
            self.classLevelPicker.reloadAllComponents()
            self.classTimePicker.reloadAllComponents()
        }
    }
    
    fileprivate func setupPickers() {
        self.classTypePicker.delegate = self
        self.classTypePicker.dataSource = self
        
        self.classesPicker.delegate = self
        self.classesPicker.dataSource = self
        
        self.classTimePicker.delegate = self
        self.classTimePicker.dataSource = self
        
        self.classLevelPicker.delegate = self
        self.classLevelPicker.dataSource = self
    }
    
    fileprivate func getClasses() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.uri))
            gateway.getClassesSubjectLists() { message in
                if let classes = message {
                    self.classes = classes;
                    let classes = self.classes.filter{ $0.college == self.colleges[0]}
                    self.selectedItemsArray = classes
                    
                    self.classesPicker.reloadAllComponents()
                    self.classLevelPicker.reloadAllComponents()
                    self.classTimePicker.reloadAllComponents()
                }
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
}
