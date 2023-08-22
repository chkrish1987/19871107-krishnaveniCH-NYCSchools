//
//  NYCHighSchool.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation

struct NYCHighSchool: Codable {
    let dbn : String?
    let schoolName : String?
    let website : String?
    let totalStudents : String?
    let addressLine1 : String?
    let city : String?
    let zip : String?
    let stateCode : String?
    let phNum : String?
    let overView: String?
    let location: String?


    enum CodingKeys: String, CodingKey {

        case schoolName = "school_name"
        case website = "website"
        case totalStudents = "total_students"
        case addressLine1 = "primary_address_line_1"
        case city = "city"
        case zip = "zip"
        case stateCode = "state_code"
        case phNum = "phone_number"
        case dbn = "dbn"
        case overView = "overview_paragraph"
        case location = "location"
    }
}

class NYCHighSchools: NSObject {

    var dbn : String?
    var schoolName : String?
    var website : String?
    var totalStudents : String?
    var address : String?
    var phNum : String?
    var overviewParagraph: String?
    var satCriticalReadingAvgScore: String?
    var satMathAvgScore: String?
    var satWritinAvgScore: String?

}

