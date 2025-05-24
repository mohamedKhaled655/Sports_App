//
//  LeagueStandingsResponse.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

import Foundation
struct LeagueStandingsResponse: Codable {
    let success: Int
    let result: ResultData
}

struct ResultData: Codable {
    let total: [TeamStanding]
}
