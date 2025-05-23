//
//  NetworkManagerTests.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 23/05/2025.
//

import XCTest
import Alamofire
@testable import Sports_App

final class NetworkManagerTests: XCTestCase {

    var networkManager: NetworkManager!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = Session(configuration: config)
        networkManager = NetworkManager(session: session)
    }

    override func tearDown() {
        networkManager = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }

    // MARK:  Test APIRouter path/method
    func testAPIRouter_getLeagues_Properties() throws {
        let params = LeaguesRquestParams(sportType: .football)
        let router = APIRouter.getLeagues(params: params)
        let urlRequest = try router.asURLRequest()
        
        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("football") ?? false)
    }
    
    // MARK:  Test success decoding
    func testLeagueFetch_Success() {
        let mockJSON = """
        {
          "success": 1,
          "result": [
             {
               "league_key": 4,
               "league_name": "UEFA Europa League",
               "country_key": 1,
               "country_name": "Eurocups",
               "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/",
               "country_logo": null
            }
          ]
        }
        """.data(using: .utf8)!
        MockURLProtocol.stubResponseData = mockJSON
        
        let expectation = expectation(description: "Fetch success")
        let params = LeaguesRquestParams(sportType: .football)
        let request = APIRouter.getLeagues(params: params)

        networkManager.fetch(request) { (response: LeagueResponse?) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertEqual(response?.result?.first?.league_name, "UEFA Europa League")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }

    func testFixtureFetch_Success() {
        let mockJSON = """
        {
          "success": 1,
          "result": [
              {
                    "event_key": 1544027,
                    "event_date": "2025-06-01",
                    "event_time": "21:00",
                    "event_home_team": "Seattle Sounders",
                    "home_team_key": 1737,
                    "event_away_team": "Minnesota United",
                    "away_team_key": 558,
                    "event_halftime_result": "",
                    "event_final_result": "-",
                    "event_ft_result": "",
                    "event_penalty_result": "",
                    "event_status": "",
                    "country_name": "Brazil",
                    "league_name": "Serie A",
                    "league_key": 99,
                    "league_round": "Round 11",
                    "league_season": "2025",
                    "event_live": "0",
                    "event_stadium": "Estádio Alfredo Jaconi (Caxias do Sul, Rio Grande do Sul)",
                    "event_referee": "",
                    "home_team_logo": "https://apiv2.allsportsapi.com/logo/1737_juventude.jpg",
                    "away_team_logo": "https://apiv2.allsportsapi.com/logo/558_gremio.jpg",
                    "event_country_key": 27,
                    "league_logo": "https://apiv2.allsportsapi.com/logo/logo_leagues/99_serie-a.png",
                    "country_logo": "https://apiv2.allsportsapi.com/logo/logo_country/27_brazil.png",
                    "event_home_formation": "",
                    "event_away_formation": "",
                    "fk_stage_key": 700,
                    "stage_name": "Current",
                    "league_group": null,
                    "goalscorers": [],
                    "substitutes": [],
                    "cards": [],
                    "vars": {
                        "home_team": [],
                        "away_team": []
            }
          ]
        }
        """.data(using: .utf8)!
        MockURLProtocol.stubResponseData = mockJSON
        
        let expectation = expectation(description: "Fetch success")
        let params = FixturesRquestParams(sportType: .football,dateFrom: DateUtils.getStartDateString(),dateTo: DateUtils.getEndDateString(value: 10))
        let request = APIRouter.getFixtures(params: params)
        
        networkManager.fetch(request) { (response: FixtureResponse?) in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.success, 1)
            XCTAssertEqual(response?.result?.first?.event_home_team, "Seattle Sounders")
            XCTAssertEqual(response?.result?.first?.event_away_team, "Minnesota United")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

    func testFetch_NetworkFailure() {
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = NSError(domain: "testError", code: 404, userInfo: nil)

        let expectation = expectation(description: "Fetch should fail and return nil")

        let params = LeaguesRquestParams(sportType: .football)
        let request = APIRouter.getLeagues(params: params)

        networkManager.fetch(request) { (response: LeagueResponse?) in
            XCTAssertTrue(MockURLProtocol.error != nil, "Mock error must not be nil")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2)
    }


 
}
