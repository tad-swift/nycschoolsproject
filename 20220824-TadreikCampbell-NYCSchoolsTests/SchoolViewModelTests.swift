//
//  SchoolViewModelTests.swift
//  20220824-TadreikCampbell-NYCSchoolsTests
//
//  Created by Tadreik Campbell on 8/25/22.
//

import XCTest
@testable import _0220824_TadreikCampbell_NYCSchools


class SchoolViewModelTests: XCTestCase {
    
    var dataFetcher: DataFetcher!
    var school: School!
    var vm: SchoolVCViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataFetcher = MockDataFetcher()
        school = School(name: "", overviewParagraph: "", id: UUID().uuidString)
        vm = SchoolVCViewModel(school: school, dataFetcher: dataFetcher)
    }
    
    override func tearDownWithError() throws {
        dataFetcher = nil
        vm = nil
        school = nil
        try super.tearDownWithError()
    }
    
    func testDidFetchData() throws {
        XCTAssert(!vm.scores.isEmpty)
    }
    
}

