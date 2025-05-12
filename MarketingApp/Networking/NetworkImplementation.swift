//
//  NetworkImplementation.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<R: NetworkRequest>(from request: R) async throws -> R.ResponseModel
}

public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

final class NetworkService: NetworkServiceProtocol {
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
        
    private let session: URLSession
    
    /// Generic network request function
    func fetch<R: NetworkRequest>(from request: R) async throws -> R.ResponseModel {
        guard let urlRequest = request.urlRequest else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        // Ensure response is HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknownError(-1) // Unknown error
        }
        
        // Handle different HTTP status codes
        switch httpResponse.statusCode {
        case 200...299:
            break // Success, continue decoding
        case 400:
            throw NetworkError.badRequest
        case 401:
            throw NetworkError.unauthorized
        case 403:
            throw NetworkError.forbidden
        case 404:
            throw NetworkError.notFound
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.unknownError(httpResponse.statusCode)
        }
        
        // Ensure there's data
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        if R.ResponseModel.self == Data.self {
            return data as! R.ResponseModel
        }
        
        // Decode response
        do {
            return try JSONDecoder().decode(R.ResponseModel.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

}
