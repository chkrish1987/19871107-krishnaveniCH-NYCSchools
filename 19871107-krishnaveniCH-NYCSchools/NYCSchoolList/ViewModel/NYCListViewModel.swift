//
//  NYCListViewModel.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import CoreLocation
import MapKit


class NYCListViewModel {
    
    var schoolList = [NYCHighSchools]() {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    var reloadTableData : (() -> Void)? = nil
    
    var filteredSchoolList = [NYCHighSchools]() {
        didSet {
            if let reloadBlock = self.reloadTableData {
                reloadBlock()
            }
        }
    }
    
    func fetchSchoolList() {
        NetworkManager.shared.getNYCSchoolList() { [weak self](schoolListResponse) in
            if let schoolResponse = schoolListResponse {
                for school in schoolResponse {
                    let nycschool = NYCHighSchools()
                    nycschool.schoolName = school.schoolName
                    nycschool.dbn = school.dbn
                    nycschool.phNum = school.phNum
                    nycschool.website = school.website
                    nycschool.address = school.location
                    nycschool.overviewParagraph = school.overView
                    nycschool.totalStudents = school.totalStudents
                    self?.schoolList.append(nycschool)
                }
                self?.fetchDetailSchoolList()
                self?.filteredSchoolList = (self?.schoolList)!
            }
        }
    }
    
    func fetchDetailSchoolList() {
        NetworkManager.shared.getNYCSchoolDetail() { [weak self](schoolListResponse) in
            if let schoolResponse = schoolListResponse {
                for schoolDetail in schoolResponse {
                    let matchedHighSchools = self?.schoolList.first(where: { (nycHighSchool) -> Bool in
                        return nycHighSchool.dbn == schoolDetail.dbn
                        })
                        guard matchedHighSchools != nil else{
                            continue
                        }
                    matchedHighSchools?.satCriticalReadingAvgScore = schoolDetail.satTakers
                    matchedHighSchools?.satMathAvgScore = schoolDetail.mathScore
                    matchedHighSchools?.satWritinAvgScore = schoolDetail.satScore
                    }
                }
            
        }
    }
    
    func filterSchoolList(searchText: String) {
        filteredSchoolList = (schoolList.filter({( schools : NYCHighSchools) -> Bool in
            return schools.schoolName!.lowercased().contains(searchText.lowercased())
        }))
    }

    
    /// This function will fetch the address without coodinates
    ///
    /// - Returns: Stirng, address of the high school
   func getCompleteAddressWithoutCoordinate(_ schoolAddr: String?) -> String{
        if let schoolAddress = schoolAddr{
            let address = schoolAddress.components(separatedBy: "(")
            let finalAddres = address.first?.components(separatedBy: ",")
            return (finalAddres?.first ?? "") + "\n" + (finalAddres?.last ?? "")
        }
        return ""
    }
    
    /// This function will fetch the coodinates for the selected High School location
    ///
    /// - Returns: CLLocationCoordinate2D, coodinate of High School location
    func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D?{
        if let schoolAddress = schoolAddr{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
    
   
}
