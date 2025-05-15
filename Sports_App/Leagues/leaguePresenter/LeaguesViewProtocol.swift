//
//  LeaguesViewProtocol.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation

protocol LeaguesViewProtocol {
    func showLeagues(_ leagues: [LeagueModel])
    func showError(_ message: String)
}
