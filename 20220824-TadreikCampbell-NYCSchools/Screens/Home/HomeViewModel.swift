//
//  HomeViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

final class HomeViewModel {
    
    @Published var schools: [School] = []
    @Published var errorMessage = ""
    
    init() {
        fetchNextSchools()
    }
    
    func fetchNextSchools() {
        let query = SchoolQuery()
            .fetchSchools()
        DataFetcher.shared.getSchools(query: query) { [weak self] schools, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
            self?.schools = schools
        }
    }
    
}
