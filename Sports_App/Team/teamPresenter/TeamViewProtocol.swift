//
//  TeamViewProtocol.swift
//  Sports_App
//
//  Created by Macos on 19/05/2025.
//

import Foundation

protocol TeamViewProtocol {
    func showLeagues(_ team: [Team])
    func showError(_ message: String)
}
