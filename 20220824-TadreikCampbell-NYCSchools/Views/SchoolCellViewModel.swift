//
//  SchoolCellViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

class SchoolCellViewModel {
    
    @Published var schoolName = ""
    @Published var schoolDescription = ""
    
    init(school: School) {
        self.schoolName = school.name
        self.schoolDescription = school.overviewParagraph
    }
    
}
