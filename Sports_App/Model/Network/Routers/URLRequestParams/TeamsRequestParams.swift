//
//  TeamsRequestParams.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

import Foundation
struct TeamsRequestParams: URLRequestParams {
    var sportType: SportsType
    var teamId: Int?
    
    init(sportType: SportsType, teamId: Int? = nil) {
        self.teamId = teamId
        self.sportType = sportType
    }
    func asDictionary(API_KEY apiKey: String) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["APIkey"] = apiKey
        if let teamId{
            dictionary["teamId"] = teamId
        }
        dictionary["met"] = SportsMethodType.Standings.rawValue
        return dictionary
    }
    
    
}
