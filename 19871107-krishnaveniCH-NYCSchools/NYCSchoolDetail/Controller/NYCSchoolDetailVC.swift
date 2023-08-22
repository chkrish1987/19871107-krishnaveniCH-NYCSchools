//
//  NYCSchoolDetailVC.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import UIKit

class NYCSchoolDetailVC: UITableViewController {
    
    var  nycHighSchool: NYCHighSchools = NYCHighSchools()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nycHighSchool.schoolName
    }

}

extension NYCSchoolDetailVC {
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return DetailCells.tableViewCellWithSATScore(self.tableView, HSWithSatScore: self.nycHighSchool)
        case 1:
            return DetailCells.tableViewCellWithOverView(self.tableView, HSWithSatScore: self.nycHighSchool)
        case 2:
            return DetailCells.tableViewCellWithContactInfo(self.tableView, HSWithSatScore: self.nycHighSchool)
        default:
            return DetailCells.tableViewCellWithAddress(self.tableView, HSWithSatScore: self.nycHighSchool)
        }
    }
    
    //MARK: - UITable View Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,1,2:
            return UITableView.automaticDimension
        default:
            return UIScreen.main.bounds.width * 0.7
        }
    }
    
}
