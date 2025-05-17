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
    
    func fetchLeagues(_ sportName: String){
        guard let sportType =  SportsType(rawValue: sportName) else {
            return
        }
        let url = APIRouter.getLeagues(params: LeaguesRquestParams(sportType: sportType))
        networkManager.fetch(url){ (response: LeagueResponse?) in
            if let leagues = response?.result{
                self.view?.showLeagues(leagues)
            }else {
                self.view?.showError("Failed to fetch leagues.")
            }
            
        }
    }
    
}
