//
//  NetworkManager.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {
    private let baseURL = "https://apiv2.allsportsapi.com/"
        
         func fetchDataFromApi<T: Codable>(
            endPoint: String,
            completionHandler: @escaping (T?) -> Void
        ) {
           
            let fullUrl = baseURL + endPoint
            
            guard let url = URL(string: fullUrl) else {
                print("Invalid URL")
                completionHandler(nil)
                return
            }

          
            AF.request(url).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completionHandler(result)
                    } catch {
                        print("Decoding Error: \(error.localizedDescription)")
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            }
        }
    
    func fetch<T>(_ requestBuilder: any Alamofire.URLRequestConvertible, completionHandler: @escaping (T?) -> Void) where T : Decodable, T : Encodable {
        
        AF.request(requestBuilder).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result)
                } catch {
                    print("Decoding Error: \(error.localizedDescription)")
                    completionHandler(nil)
                }
            case .failure(let error):
                print("Request failed with error: \(error.localizedDescription)")
                completionHandler(nil)
            }
        }
    }
}

