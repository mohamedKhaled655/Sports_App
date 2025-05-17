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
    func fetchFixtures(_ sportName: String,id: Int){
        guard let sportType = SportsType(rawValue: sportName) else { return }
        let params = FixturesRquestParams(
            sportType: sportType,
            dateFrom: DateUtils.getStartDateString(),
            dateTo: DateUtils.getEndDateString(value: 14),
            leagureId: id
        )
        let apiRouter = APIRouter.getFixtures(
            params: params
        )
        
        networkManager.fetch(apiRouter) { [weak self] (response: FixtureResponse?) in
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
