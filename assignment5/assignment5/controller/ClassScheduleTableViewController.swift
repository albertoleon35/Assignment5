//
//  ClassScheduleTableViewController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/27/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class ClassScheduleTableViewController: UITableViewController {
    
    var student: Student?
    var classIds : [Int]?
    var waitListIds : [Int]?
    var studentClasses : StudentClasses?
    let studentClassesUri = "studentclasses"
    let classDetailsUri = "classdetails"
    var classDetailArray = [ClassDetailsResponse]()
    let cellIdentifier = "classDetail"
    let toClassDetailFromViewSchedule = "toClassDetailFromViewSchedule"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getStudentClasses()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classDetailArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel!.text = !classDetailArray[indexPath.row].fullTitle.isEmpty ? classDetailArray[indexPath.row].fullTitle : classDetailArray[indexPath.row].title
        
        return cell;
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.toClassDetailFromViewSchedule, let filteredClassViewController = segue.destination as? ClassDetailViewController  {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                filteredClassViewController.classDetail = self.classDetailArray[selectedRow]
                filteredClassViewController.flagSegue = self.toClassDetailFromViewSchedule
            }
        }
    }
    
    fileprivate func getStudentClasses() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.studentClassesUri))
            guard let student = AppState.student else {
                return
            }
            
            gateway.getStudentClasses(student: ClassStudentDTO(redid: student.redid, password: student.password)) { response in
                self.studentClasses = response
                self.getClassesDetails()
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
    
    
    fileprivate func getClassesDetails() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.classDetailsUri))
            guard let classes = studentClasses else {
                return
            }
            var ids = [Int]()
            
            for id in classes.classes {
                ids.append(id)
            }
            
            for id in classes.waitlist {
                ids.append(id)
            }
            
            let classIdsDTO = ClassIds(classids: ids)
            gateway.getClassDetails(classIds: classIdsDTO) { response in
                print(response)
                self.classDetailArray = response
                self.tableView.reloadData()
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
}
