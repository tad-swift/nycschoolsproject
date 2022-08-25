//
//  SATScore.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/24/22.
//

import Foundation

struct SATScore: Codable {
    
    let math: String?
    let reading: String?
    let writing: String?
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case math = "sat_math_avg_score"
        case reading = "sat_critical_reading_avg_score"
        case writing = "sat_writing_avg_score"
        case id = "dbn"
    }
    
}
