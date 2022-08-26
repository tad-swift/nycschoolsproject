//
//  HomeViewModelTests.swift
//  20220824-TadreikCampbell-NYCSchoolsTests
//
//  Created by Tadreik Campbell on 8/25/22.
//

import XCTest
@testable import _0220824_TadreikCampbell_NYCSchools

class HomeViewModelTests: XCTestCase {
    
    var dataFetcher: DataFetcher!
    var vm: HomeViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataFetcher = MockDataFetcher()
        vm = HomeViewModel(dataFetcher: dataFetcher)
    }
    
    override func tearDownWithError() throws {
        dataFetcher = nil
        vm = nil
        try super.tearDownWithError()
    }
    
    func testFetchNextSchools() throws {
        XCTAssert(!vm.schools.isEmpty)
    }
    
}

