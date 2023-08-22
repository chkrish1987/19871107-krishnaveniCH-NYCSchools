//
//  NYCSchoolTests.swift
//  19871107-krishnaveniCH-NYCSchoolsTests
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation
import XCTest
@testable import _9871107_krishnaveniCH_NYCSchools

class NYCSchoolTests: XCTestCase {

    var sut: NYCListViewModel!
    
    override func setUp() {
        sut = NYCListViewModel()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "SchoolList", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
          
        let url = URL(string: AppConstants.API.schoolList)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        NetworkManager.shared.apiHelper.session = sessionMock
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_SchoolList_ParsesData() {
       let promise = expectation(description: "Status code: 200")
      
        XCTAssertEqual(sut.schoolList.count, 0, "school array should be empty before the data task runs")
        weak var weakSelf = self
        NetworkManager.shared.getNYCSchoolList { (schoolListResponse) in
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
                    weakSelf?.sut.schoolList.append(nycschool)
                    
                }
                
                weakSelf?.sut.filteredSchoolList = (weakSelf?.sut.schoolList)!
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(sut.schoolList.count, 440, "Didn't parse 440 items from fake response")
    }
    
    func test_SchoolDetail_ParsesData() {
        sut = NYCListViewModel()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Detail", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
      
        let url = URL(string: AppConstants.API.schoolDetail)
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
        NetworkManager.shared.apiHelper.session = sessionMock
       let promise = expectation(description: "Status code: 200")
      
        XCTAssertEqual(sut.schoolList.count, 0, "school array should be empty before the data task runs")
        weak var weakSelf = self
        NetworkManager.shared.getNYCSchoolDetail { (schoolDetailResponse) in
            if let schoolResponse = schoolDetailResponse {
                for school in schoolResponse {
                    let nycschool = NYCHighSchools()
                    nycschool.satWritinAvgScore = school.satScore
                    nycschool.satMathAvgScore = school.mathScore
                    nycschool.satCriticalReadingAvgScore = school.satTakers
                    weakSelf?.sut.schoolList.append(nycschool)
                    
                }
                
                weakSelf?.sut.filteredSchoolList = (weakSelf?.sut.schoolList)!
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(sut.schoolList.count, 478, "Didn't parse 440 items from fake response")
    }
    
    
}
