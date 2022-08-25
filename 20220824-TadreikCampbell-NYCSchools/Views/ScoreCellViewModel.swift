//
//  ScoreCellViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

class ScoreCellViewModel {
    
    @Published var reading = ""
    @Published var writing = ""
    @Published var math = ""
    
    init(score: SATScore) {
        reading = score.reading ?? "No reading score"
        writing = score.writing ?? "No writing score"
        math = score.math ?? "No math score"
    }
    
}
