//
//  LeaguesPresenter.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation

class LeaguesPresenter {
    var leagues: [LeagueModel] = []
    var view : LeaguesViewProtocol?
    var networkManager: NetworkProtocol
    
    init(view: LeaguesViewProtocol, networkManager: NetworkProtocol){
        self.view = view
        self.networkManager = networkManager
    }
    
    func fetchLeagues(_ sportName: String) {
        guard let sportType = SportsType(rawValue: sportName) else {
            return
        }
        
        let url = APIRouter.getLeagues(params: LeaguesRquestParams(sportType: sportType))
        
        networkManager.fetch(url) { (response: LeagueResponse?) in
            if let leagues = response?.result {
                self.leagues = leagues
                self.view?.showLeagues(leagues)
            } else {
                self.view?.showError("Failed to fetch leagues.")
            }
        }
    }
    
    func searchLeagues(with query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        if trimmed.isEmpty {
            view?.showLeagues(leagues)
        } else {
            let filtered = leagues.filter {
                ($0.league_name ?? "").lowercased().contains(trimmed)
            }.sorted {
                let name1 = $0.league_name?.lowercased() ?? ""
                let name2 = $1.league_name?.lowercased() ?? ""
                let startsWith1 = name1.hasPrefix(trimmed)
                let startsWith2 = name2.hasPrefix(trimmed)

                if startsWith1 && !startsWith2 {
                    return true
                } else if !startsWith1 && startsWith2 {
                    return false
                } else {
                    return name1 < name2
                }
            }

            view?.showLeagues(filtered)
        }
    }
    
}
