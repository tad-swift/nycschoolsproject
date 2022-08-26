//
//  SchoolVCViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

class SchoolVCViewModel {
    
    var dataFetcher: DataFetcher
    var school: School
    
    var schoolName = ""
    @Published var scores: [SATScore] = []
    @Published var errorMessage = ""
    
    init(school: School, dataFetcher: DataFetcher) {
        self.school = school
        self.dataFetcher = dataFetcher
        getScores()
    }
    
    // func to fetch scores
    func getScores() {
        let query = SchoolQuery().fetchScores()
        dataFetcher.getScores(query: query) { [weak self] fetchedScores, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
            self.scores = fetchedScores.filter { $0.id == self.school.id }
        }
    }
    
}
