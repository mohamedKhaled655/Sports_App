//
//  NetworkManager.swift
//  Sports_App
//
//  Created by Macos on 15/05/2025.
//

import Foundation
import Alamofire

class NetworkManager: NetworkProtocol {

    private let session: Session

      init(session: Session = AF) {
          self.session = session
      }
    func fetch<T>(_ requestBuilder: any Alamofire.URLRequestConvertible, completionHandler: @escaping (T?) -> Void) where T : Decodable, T : Encodable {
        
        session.request(requestBuilder).validate().responseData { response in
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

