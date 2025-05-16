//
//  DetialsPresenter.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//
import Foundation

class DetialsPresenter {
    var fixture: [FixtureModel] = []
    var view : DetialsViewProtocol?
    var networkManager: NetworkProtocol
    //MARK:- initialization
    init(view: DetialsViewProtocol, networkManager: NetworkProtocol){
        self.view = view
        self.networkManager = networkManager
    }
    func fetchFixtures(_ sportName: String,id: Int){
        let url = UrlSportBuilder(sportType: sportName, methodType: MethodType.Fixtures)
            .appendDateFromTo()
            .appendLeagueID(id: id)
            .toString()
        
        networkManager.fetchDataFromApi(url: url) { [weak self] (response: FixtureResponse?) in
            guard let self = self else { return }
            if let fixture = response?.result {
                self.view?.showFixture(fixture)
                print("fixture fetched \(fixture.count)")
            } else {
                self.view?.showError("Failed to fetch fixtures.")
            }
        }
    }
}
