//
//  Query.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

protocol Query {
    var url: URL { get }
}

struct APIDefaults {
    static let NYCSchoolAPIBaseDomain = "data.cityofnewyork.us"
    static let schoolEndpoint = "/resource/s3k6-pzi2.json"
    static let scoresEndpoint = "/resource/f9bf-2cp4.json"
}
