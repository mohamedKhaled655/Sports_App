//
//  Untitled.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

struct FixturesRquestParams: URLRequestParams {
    var sportType: SportsType
    let leagureId: Int?
    let dateFrom: String
    let dateTo: String
    
    init(sportType: SportsType, dateFrom: String, dateTo: String, leagureId: Int? = nil) {
        self.leagureId = leagureId
        self.sportType = sportType
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
    
    func asDictionary(API_KEY apiKey: String) -> [String : Any] {
        var dictionary: [String: Any] = [:]
        dictionary["APIkey"] = apiKey
        if sportType == .tennis {
            if let leagureId {
                dictionary["league_key"] = leagureId
            }
        }else{
            if let leagureId {
                dictionary["leagueId"] = leagureId
            }
        }
        dictionary["met"] = SportsMethodType.Fixtures.rawValue
        dictionary["from"] = dateFrom
        dictionary["to"] = dateTo
        return dictionary
    }
}
