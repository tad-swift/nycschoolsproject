//
//  DataFetcher.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import Foundation

protocol DataFetcher {
    func getSchools<AnyQuery: Query>(query: AnyQuery, completion: @escaping ([School], Error?) -> Void)
    func getScores<AnyQuery: Query>(query: AnyQuery, completion: @escaping ([SATScore], Error?) -> Void)
}

class SchoolDataFetcher: DataFetcher {
    
    static let shared = SchoolDataFetcher()
    
    private init() { }
    
    func getSchools<AnyQuery: Query>(query: AnyQuery, completion: @escaping ([School], Error?) -> Void) {
        var request = URLRequest(url: query.url)
        request.addValue(APIKeys.appToken, forHTTPHeaderField: "X-App-Token")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion([], error)
                return
            }
            if let data = data {
                do {
                    // Usually I would do it this way but there is some error with getting the fields
//                    let schools = try JSONDecoder().decode([School].self, from: data)
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {
                        completion([], nil)
                        return
                    }
                    var schools: [School] = []
                    for school in json {
                        let name = school["school_name"] as? String
                        let overview = school["overview_paragraph"] as? String
                        let dbn = school["dbn"] as! String
                        let school = School(name: name, overviewParagraph: overview, id: dbn)
                        schools.append(school)
                    }
                    completion(schools, nil)
                } catch {
                    completion([], error)
                }
                return
            }
        }).resume()
    }
    
    func getScores<AnyQuery: Query>(query: AnyQuery, completion: @escaping ([SATScore], Error?) -> Void) {
        var request = URLRequest(url: query.url)
        request.addValue(APIKeys.appToken, forHTTPHeaderField: "X-App-Token")
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            if let error = error {
                completion([], error)
                return
            }
            
            if let data = data {
                do {
//                    let score = try JSONDecoder().decode(SATScore.self, from: data)
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]] else {
                        completion([], NSError(domain: "decode failed", code: 0))
                        return
                    }
                    var scores: [SATScore] = []
                    for score in json {
                        let newScore = SATScore(
                            math: score["sat_math_avg_score"] as? String,
                            reading: score["sat_critical_reading_avg_score"] as? String,
                            writing: score["sat_writing_avg_score"] as? String,
                            id: score["dbn"] as! String)
                        scores.append(newScore)
                    }
                    completion(scores, nil)
                } catch {
                    completion([], error)
                }
                return
            }
        }).resume()
    }
    
}
