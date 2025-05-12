//
//  TargetSpecificsDataAccessor.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//

import Foundation
import Combine

class TargetSpecificsDataAccessor {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetch() async throws -> [TargetingSpecifics] {
        let targetSpecificsRequest = TargetSpecificsRequest()
        let targetSpecificsResponse = try await networkService.fetch(from: targetSpecificsRequest)
        sleep(3)
        return targetSpecificsResponse.record
        
    }
}
