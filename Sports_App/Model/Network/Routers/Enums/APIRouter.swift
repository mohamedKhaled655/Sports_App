//
//  UrlBuilder.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 16/05/2025.
//
import Foundation
import Alamofire

enum APIRouter: URLRequestBuilder {
    case getFixtures(
        params: URLRequestParams
    )
    
    case getLeagues(
        params: URLRequestParams
    )
    
    case getStandingTeams(
        params: URLRequestParams
    )
    
    case getTeams(
        params: URLRequestParams
    )

    // MARK: - Base URL
    var baseURL: URL {
        guard let baseURL = URL(string: "https://apiv2.allsportsapi.com/") else {
            return URL(string: "")!
        }
        return baseURL
    }

    var API_KEY: String {
        return "0a986c69d14837fcda0d3c098123b0acd7c7ff340baa1ff5aa50bd828473f990"
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .getFixtures(let params), .getLeagues(let params) , .getTeams(let params):
            return "/\(params.sportType.rawValue)"
        case .getStandingTeams(let params):
            return "/\(params.sportType.rawValue)"
        }
    }

    // MARK: - HTTP Method
    var method: HTTPMethod {
        switch self {
        case .getFixtures, .getLeagues , .getStandingTeams , .getTeams:
            return .get
        }
    }

    // MARK: - Headers (Add API Key Here)
    var headers: HTTPHeaders? {
        return [:]
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .getFixtures(let params), .getLeagues(let params) , .getTeams(let params):
            return params.asDictionary(API_KEY: API_KEY)
        case .getStandingTeams(let params):
            return params.asDictionary(API_KEY: API_KEY)
        }
    }

    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch method {
        case .get, .delete:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try encoding.encode(request, with: parameters)
    }
}
