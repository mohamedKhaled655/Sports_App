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
//        let url = "\(sportName)/?met=Leagues&APIkey=0a986c69d14837fcda0d3c098123b0acd7c7ff340baa1ff5aa50bd828473f990"
       
        let url = UrlSportBuilder(sportType: sportName, methodType: MethodType.Leagues).toString()
        
        networkManager.fetchDataFromApi(url: url){ (response: LeagueResponse?) in
            if let leagues = response?.result{
                self.view?.showLeagues(leagues)
            }else {
                self.view?.showError("Failed to fetch leagues.")
            }
            
        }
    }
    
}
