//
//  FilteredClassesViewController.swift
//  assignment5
//
//  Created by Alberto Leon on 11/25/18.
//  Copyright © 2018 Alberto Leon. All rights reserved.
//

import UIKit

class FilteredClassesViewController: UITableViewController  {
    var classDetailDTO : ClassDetailDTO?;
    var classIds : [Int]?
    var classDetailArray = [ClassDetailsResponse]()
    var classDetail: ClassDetailsResponse?

    
    let classIdUri = "classidslist"
    let classDetailsUri = "classdetails"
    let cellIdentifier = "ClassDetail"
    let messageAlert = "No classes available"
    let segueIdentifierToClassDetail = "toClassDetailsFromClassDetailsTableView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getClassIds()
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
        if segue.identifier == self.segueIdentifierToClassDetail, let filteredClassViewController = segue.destination as? ClassDetailViewController  {
            if let indexPath = tableView.indexPathForSelectedRow{
                let selectedRow = indexPath.row
                filteredClassViewController.classDetail = self.classDetailArray[selectedRow]
                filteredClassViewController.flagSegue = self.segueIdentifierToClassDetail
            }
        }
    }
    
    fileprivate func getClassIds() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: classIdUri))
            guard let classDetail = self.classDetailDTO else {
                return;
            }
            guard let id = Int(classDetail.classResponse.id) else {
                return;
            }
            
            let subjectDTO = Subject(subjectids: [id], level: classDetail.levelAdapter(), starttime: classDetail.startTime, endtime: classDetail.endTime)
            
            gateway.getClassIdsLists(classDetail: subjectDTO) { response in
                self.classIds = response;
                self.getClassesDetails()
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
    
    fileprivate func getClassesDetails() {
        do {
            let gateway = try Gateway(url: Constants.getUrl(uri: self.classDetailsUri))
            guard let ids = classIds else {
                return
            }
            
            let classIdsDTO = ClassIds(classids: ids)
            
            gateway.getClassDetails(classIds: classIdsDTO) { response in
                print(response)
                self.classDetailArray = response
                if(self.classDetailArray.isEmpty) {
                    self.displayAlert()
                    return;
                }
                self.tableView.reloadData()
            }
        } catch ErrorException.errorMessage(_) {
        } catch {
        }
    }
    
    fileprivate func displayAlert() {
        let alert = UIAlertController(title: "\(self.messageAlert)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
