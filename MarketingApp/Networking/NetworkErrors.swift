//
//  NetworkErrors.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//

import Foundation

enum NetworkError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500-599
    case decodingError(Error)
    case unknownError(Int)
    case noData
    case invalidURL
}
