//
//  NYCSchoolDetail.swift
//  19871107-krishnaveniCH-NYCSchools
//
//  Created by Krishnaveni on 22/08/23.
//

import Foundation

struct NYCSchoolDetail: Codable {
    let dbn : String?
    let satTakers : String?
    let satScore : String?
    let mathScore : String?
    let name : String?
    

    enum CodingKeys: String, CodingKey {

        case dbn = "dbn"
        case satTakers = "num_of_sat_test_takers"
        case satScore = "sat_writing_avg_score"
        case mathScore = "sat_math_avg_score"
        case name = "school_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decodeIfPresent(String.self, forKey: .dbn)
        satTakers = try values.decodeIfPresent(String.self, forKey: .satTakers)
        satScore = try values.decodeIfPresent(String.self, forKey: .satScore)
        mathScore = try values.decodeIfPresent(String.self, forKey: .mathScore)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
