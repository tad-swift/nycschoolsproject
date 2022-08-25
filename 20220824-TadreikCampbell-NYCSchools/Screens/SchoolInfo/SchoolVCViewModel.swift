//
//  SchoolVCViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

class SchoolVCViewModel {
    
    var school: School
    
    @Published var schoolName = ""
    @Published var scores: [Int] = []
    
    init(school: School) {
        self.school = school
        self.schoolName = school.name ?? ""
    }
    
    // func to fetch scores
    
    
}
