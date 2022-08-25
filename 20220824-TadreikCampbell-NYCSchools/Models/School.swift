//
//  School.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/24/22.
//

import Foundation

class School: Codable {
    
    let name: String
    let overviewParagraph: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case name = "school_ name"
        case overviewParagraph = "overview_paragraph"
        case id = "dbn"
    }
    
}
