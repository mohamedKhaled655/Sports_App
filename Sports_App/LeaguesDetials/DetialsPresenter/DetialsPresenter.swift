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
    init(view: DetialsViewProtocol, networkManager: NetworkProtocol = NetworkManager()){
        self.view = view
        self.networkManager = networkManager
    }
    // MARK:-  get all Fixture
    func fetchFixtures(_ sportName: String,id: Int){
        guard let sportType = SportsType(rawValue: sportName) else { return }
        let params = FixturesRquestParams(
            sportType: sportType,
            dateFrom: DateUtils.getStartDateString(),
            dateTo: DateUtils.getEndDateString(value: 30),
            leagureId: id
        )
        let apiRouter = APIRouter.getFixtures(
            params: params
        )
        networkManager.fetch(apiRouter) { [weak self] (response: FixtureResponse?) in
            guard let self = self else { return }
          
            if let fixtures = response?.result {
                self.filterFixtures(fixtures,_sportName: sportType)
            } else {
                self.view?.showError("Failed to fetch fixtures.")
            }
        }
    }
    
    // MARK:- get all teams in the leauges
    func fetchStandingTeams(_ sportName: String,id: Int){
        guard let sportType = SportsType(rawValue: sportName) else { return }
        let params = StandingRequestParams(sportType: sportType, leagureId: id)
        let apiRouter = APIRouter.getStandingTeams(
            params: params
        )
        networkManager.fetch(apiRouter) { [weak self] (response: LeagueStandingsResponse?) in
            guard let self = self else { return }
            if let standingTeams = response?.result.total {
                self.view?.showStanding(standingTeams)
                print("Standing Teams fetched \(standingTeams.count)")
            } else {
                self.view?.showError("Failed to fetch Standing Teams.")
            }
        }
    }
    
    //MARK:- Filter the Fixtures
    func filterFixtures( _ fixtures : [FixtureModel],_sportName: SportsType){
        var upcomingFixtures: [FixtureModel] = []
        var latestFixtures: [FixtureModel] = []
        if _sportName.rawValue == "cricket" {
            for fixture in fixtures {
                let homeResult = fixture.event_home_final_result ?? ""
                if homeResult.isEmpty {
                    upcomingFixtures.append(fixture)
                } else {
                    latestFixtures.append(fixture)
                }
            }
            self.view?.showUpcoming(upcomingFixtures)
            self.view?.showLatest(latestFixtures)
            print("Upcoming fixture fetched \(upcomingFixtures.count)")
            print("Latest fixture fetched \(latestFixtures.count)")
        }
        else{
            for fixture in fixtures {
                let finalResult = fixture.event_final_result ?? ""
                if finalResult ==  "-" {
                    upcomingFixtures.append(fixture)
                } else {
                    latestFixtures.append(fixture)
                }
            }
            self.view?.showUpcoming(upcomingFixtures)
            self.view?.showLatest(latestFixtures)
            print("Upcoming fixture fetched \(upcomingFixtures.count)")
            print("Latest fixture fetched \(latestFixtures.count)")
        }
    }
}
