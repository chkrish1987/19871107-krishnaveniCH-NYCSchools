//
//  AppConstants.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation

struct AppConstants {
    struct API {
        static let schoolList           = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        static let schoolDetail         = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    }
    
    struct ViewIdentifiers {
        static let HSWithSATScoreSegue = "HSWithSATScoreSegue"
    }
    
    struct Cells {
        static let nycListCell            = "nycListCell"
        static let schoolWithSATScoreCellIdentifier =  "HSSATScoresTableViewCell"
        static let schoolOverviewCellIdentifier = "HSOverViewTableViewCell"
        static let schoolWithAddressCellIdentifier = "HSAddressTableViewCell"
        static let schoolWithContactCellIdentifier = "HSContactTableViewCell"
    }
    static let noSATScoreInfomationText = "There is no SAT score information for this high school"
    static let averageSATReadingScore = "SAT Average Critical Reading Score:  "
    static let averageSATMathScore = "SAT Average Math Score:   "
    static let averageSATWritingScore = "SAT Average Writing Score:   "
}
