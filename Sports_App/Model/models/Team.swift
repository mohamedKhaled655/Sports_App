//
//  Team.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//
import Foundation

struct Team: Codable {
    let team_key: Int?
    let team_name: String?
    let team_logo: String?
    let players: [Player]?
}
