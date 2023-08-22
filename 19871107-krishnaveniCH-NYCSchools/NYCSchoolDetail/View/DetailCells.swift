//
//  DetailCell.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import UIKit

class DetailCells {
    /// This function get the selected High School name's  average sat scores
    ///
    /// - Returns: UITableViewCell
    static func tableViewCellWithSATScore(_ tableView: UITableView, HSWithSatScore: NYCHighSchools) -> UITableViewCell{
        let schoolWithSATScoresCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Cells.schoolWithSATScoreCellIdentifier) as! HSSatScoresTableViewCell
        
        schoolWithSATScoresCell.hsNameLbl.text = HSWithSatScore.schoolName
        
        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
        schoolWithSATScoresCell.satReadingAvgScoreLbl.text = (HSWithSatScore.satCriticalReadingAvgScore != nil) ?  (AppConstants.averageSATReadingScore + HSWithSatScore.satCriticalReadingAvgScore!) : AppConstants.noSATScoreInfomationText
        
        // Sets the Math Average Score
        schoolWithSATScoresCell.satMathAvgScoreLbl.isHidden = (HSWithSatScore.satMathAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satMathAvgScoreLbl.text = (HSWithSatScore.satMathAvgScore != nil) ? (AppConstants.averageSATMathScore + HSWithSatScore.satMathAvgScore!) : nil
        
        // Sets the Writing Average Score
        schoolWithSATScoresCell.satWritingAvgScoreLbl.isHidden =  (HSWithSatScore.satWritinAvgScore != nil) ? false : true
        schoolWithSATScoresCell.satWritingAvgScoreLbl.text = (HSWithSatScore.satWritinAvgScore != nil) ? (AppConstants.averageSATWritingScore + HSWithSatScore.satWritinAvgScore!) : nil
        
        return schoolWithSATScoresCell
    }
    
    /// This function get the selected high school's overview
    ///
    /// - Returns: UITableViewCell
    static func tableViewCellWithOverView(_ tableView: UITableView, HSWithSatScore: NYCHighSchools) -> UITableViewCell{
        let schoolWithOverviewCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Cells.schoolOverviewCellIdentifier) as! HSOverviewTableViewCell
        
        schoolWithOverviewCell.hsOverviewLbl.text = HSWithSatScore.overviewParagraph
        
        return schoolWithOverviewCell
    }
    
    /// This function get the high school contact information with address, tel and website.
    ///
    /// - Returns: UITableViewCell
    static func tableViewCellWithContactInfo(_ tableView: UITableView, HSWithSatScore: NYCHighSchools) -> UITableViewCell{
        let schoolWithContactCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Cells.schoolWithContactCellIdentifier) as! HSContactTableViewCell
        
        schoolWithContactCell.hsAddressLbl.text = "Address: " + NYCListViewModel().getCompleteAddressWithoutCoordinate(HSWithSatScore.address)
        schoolWithContactCell.hsPhoneLbl.text = (HSWithSatScore.phNum != nil) ? "Tel:  " + HSWithSatScore.phNum! : ""
        schoolWithContactCell.hsWebsiteLbl.text = HSWithSatScore.website
        
        return schoolWithContactCell
    }
    
    /// This function get the High School's location with annotaion on the map
    ///
    /// - Returns: UITableViewCell
    static func tableViewCellWithAddress(_ tableView: UITableView, HSWithSatScore: NYCHighSchools) -> UITableViewCell{
        let schoolWithAddressCell = tableView.dequeueReusableCell(withIdentifier: AppConstants.Cells.schoolWithAddressCellIdentifier) as! HSAddressTableViewCell
        
        if let highSchoolCoordinate = NYCListViewModel().getCoodinateForSelectedHighSchool(HSWithSatScore.address){
            schoolWithAddressCell.addHSAnnotaionWithCoordinates(highSchoolCoordinate)
        }
        
        return schoolWithAddressCell
    }
}
