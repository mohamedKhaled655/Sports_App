//
//  URLRequestParams.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//

protocol URLRequestParams: Sendable {
    var sportType: SportsType { get }
    func asDictionary(API_KEY apiKey: String) -> [String: Any]
}
