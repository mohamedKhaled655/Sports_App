//
//  TeamPresenter.swift
//  Sports_App
//
//  Created by Macos on 19/05/2025.
//

import Foundation

class TeamPresenter {
    
    var teams:[Team] = []
    var view: TeamViewProtocol?
    var networkManager: NetworkProtocol
    
    init( view: TeamViewProtocol? , networkManager: NetworkProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func fetchTeamDetails (_ sportName: String,_ teamId: Int){
        guard let sportType = SportsType(rawValue: sportName) else { return }
        let params = TeamsRequestParams(sportType: sportType, teamId: teamId )
        let apiRouter = APIRouter.getTeams(
            params: params
        )
        print("url:\(apiRouter)")
        networkManager.fetchDataFromApi(endPoint: "\(sportName)/?&met=Teams&teamId=\(teamId)&APIkey=0a986c69d14837fcda0d3c098123b0acd7c7ff340baa1ff5aa50bd828473f990"){ (response: TeamsResponse?) in
            if let players = response?.result{
                self.view?.showLeagues(players)
            }else {
                self.view?.showError("Failed to fetch players.")
            }
            
        }
    }
}
