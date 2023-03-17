//
//  NYCHighSchool.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 16/03/23.
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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        schoolName = try values.decodeIfPresent(String.self, forKey: .schoolName)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        totalStudents = try values.decodeIfPresent(String.self, forKey: .totalStudents)
        addressLine1 = try values.decodeIfPresent(String.self, forKey: .addressLine1)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
        stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
        phNum = try values.decodeIfPresent(String.self, forKey: .phNum)
        dbn = try values.decodeIfPresent(String.self, forKey: .dbn)
        overView = try values.decodeIfPresent(String.self, forKey: .overView)
        location = try values.decodeIfPresent(String.self, forKey: .location)
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

