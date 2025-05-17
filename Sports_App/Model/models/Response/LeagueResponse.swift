//
//  LeagueResponse.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation

struct LeagueResponse: Codable {
    let success: Int?
    let result: [LeagueModel]?
}
