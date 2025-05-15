//
//  NetworkManager.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
     func fetchDataFromApi<T: Codable>(
            endPoint: String,
            completionHandler: @escaping (T?) -> Void
        )
}
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
}

//class NetworkManager: NetworkProtocol {
//
//     func fetchDataFromApi<T: Codable>(
//        urlString: String,
//        completionHandler: @escaping (T?) -> Void
//    ) {
//        guard let url = URL(string: urlString) else {
//            print(" Invalid URL")
//            completionHandler(nil)
//            return
//        }
//
//        let request = URLRequest(url: url)
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: request) { data, response, error in
//
//            if let error = error {
//                print(" Request Error: \(error.localizedDescription)")
//                completionHandler(nil)
//                return
//            }
//
//            guard let data = data else {
//                print(" No Data Received")
//                completionHandler(nil)
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(T.self, from: data)
//                completionHandler(result)
//            } catch {
//                print("Decoding Error: \(error.localizedDescription)")
//                completionHandler(nil)
//            }
//        }
//
//        task.resume()
//    }
//}
