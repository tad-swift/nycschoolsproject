//
//  ScoreCellViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

class ScoreCellViewModel {
    
    var score: SATScore
    
    @Published var reading = ""
    @Published var writing = ""
    @Published var math = ""
    
    init(score: SATScore) {
        self.score = score
    }
    
}
