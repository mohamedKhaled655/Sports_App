//
//  URLRequestBuilder.swift
//  Sports_App
//
//  Created by Noha Ali Gomaa on 17/05/2025.
//
import Foundation
import Alamofire

protocol URLRequestBuilder: URLRequestConvertible {
    var baseURL: URL { get }
    var API_KEY: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}
