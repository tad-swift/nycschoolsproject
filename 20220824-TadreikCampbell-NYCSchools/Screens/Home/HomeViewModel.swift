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
    @Published var visibleSchools: [School] = []
    @Published var errorMessage = ""
    
    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
        fetchNextSchools()
    }
    
    func fetchNextSchools() {
        let query = SchoolQuery()
            .fetchSchools()
        dataFetcher.getSchools(query: query) { [weak self] schools, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
            self.schools = schools
            self.visibleSchools = self.schools
        }
    }
    
    func updateVisibleSchools(searchText: String) {
        if searchText.count == 0 {
            visibleSchools = schools
        }
        else {
            visibleSchools = schools.filter {
                return $0.name!.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
}
