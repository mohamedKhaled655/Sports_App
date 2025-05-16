//
//  FixtureResponse.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//

import Foundation

struct FixtureResponse: Codable {
    let success: Int?
    let result: [FixtureModel]?
}

