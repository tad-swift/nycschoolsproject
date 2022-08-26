//
//  HomeViewModel.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

final class HomeViewModel {
    
    var dataFetcher: DataFetcher
    
    @Published var schools: [School] = []
    @Published var errorMessage = ""
    
    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
        fetchNextSchools()
    }
    
    func fetchNextSchools() {
        let query = SchoolQuery()
            .fetchSchools()
        dataFetcher.getSchools(query: query) { [weak self] schools, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            }
            self?.schools = schools
        }
    }
    
}
