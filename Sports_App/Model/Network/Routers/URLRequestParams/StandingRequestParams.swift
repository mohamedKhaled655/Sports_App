//
//  StandingRequestParams.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//
import Foundation
struct StandingRequestParams : URLRequestParams{
    var sportType: SportsType
    var leagureId: Int?
    
    init(sportType: SportsType, leagureId: Int? = nil) {
        self.leagureId = leagureId
        self.sportType = sportType
    }
    func asDictionary(API_KEY apiKey: String) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["APIkey"] = apiKey
        if let leagureId {
            dictionary["leagueId"] = leagureId
        }
        dictionary["met"] = SportsMethodType.Standings.rawValue
        return dictionary
    }
    
    
}
