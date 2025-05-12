//
//  NetworkRequest.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//
import Foundation

protocol NetworkRequest {
    associatedtype ResponseModel: Decodable
    
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var httpMethod: String { get }
    var httpHeaders: [String: String] { get }
    
    var urlRequest: URLRequest? { get }
}

extension NetworkRequest {
    var urlRequest: URLRequest? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = httpHeaders
        
        return request
    }
    
    var baseURL: String {
        Constants.baseURL
    }
    
    var queryItems: [URLQueryItem] {
        []
    }
    
    var httpMethod: String {
        "GET"
    }
    
    var httpHeaders: HTTPHeaders {
        [:]
    }
}
