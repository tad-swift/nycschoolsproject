//
//  MockDataFetcher.swift
//  20220824-TadreikCampbell-NYCSchoolsTests
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation
@testable import _0220824_TadreikCampbell_NYCSchools

class MockDataFetcher: DataFetcher {
    func getScores<AnyQuery>(query: AnyQuery, completion: @escaping ([SATScore], Error?) -> Void) where AnyQuery : Query {
        let score = SATScore(math: "500", reading: "500", writing: "500", id: UUID().uuidString)
        completion([score], nil)
    }
    
    func getSchools<AnyQuery>(query: AnyQuery, completion: @escaping ([School], Error?) -> Void) where AnyQuery : Query {
        let school = School(name: "No name", overviewParagraph: "Description", id: UUID().uuidString)
        completion([school], nil)
    }
}
