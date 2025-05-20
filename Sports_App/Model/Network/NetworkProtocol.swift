//
//  NetwotkManagerProtocol.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//
import Alamofire

protocol NetworkProtocol {
    func fetch<T: Codable>(
        _ requestBuilder: URLRequestConvertible,
        completionHandler: @escaping (T?) -> Void
    )
    
    func fetchDataFromApi<T: Codable>(
                endPoint: String,
                completionHandler: @escaping (T?) -> Void
            )
}
