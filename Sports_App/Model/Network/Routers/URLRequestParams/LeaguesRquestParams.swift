//
//  Untitled.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

struct LeaguesRquestParams: URLRequestParams {
    var sportType: SportsType
    
    init(sportType: SportsType) {
        self.sportType = sportType
    }
    
    func asDictionary(API_KEY apiKey: String) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["APIkey"] = apiKey
        dictionary["met"] = SportsMethodType.Leagues.rawValue
        return dictionary
    }
}
