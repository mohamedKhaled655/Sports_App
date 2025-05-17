//
//  DetialsViewProtocol.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//

import Foundation

protocol DetialsViewProtocol{
    func showFixture(_ fixture: [FixtureModel] )
    func showStanding(_ standingTeams: [TeamStanding] )
    func showError(_ message: String)
}
