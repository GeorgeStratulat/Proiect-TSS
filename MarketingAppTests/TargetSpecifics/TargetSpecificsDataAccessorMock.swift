//
//  TargetSpecificsDataAccessorMock.swift
//  MarketingAppTests
//
//  Created by George Stratulat on 20.05.2024.
//

import Foundation
import Combine

class TargetSpecificsDataAccessorMock: TargetSpecificsDataAccessor {
    init(targetingSpecifics: [TargetingSpecifics] = [], shouldError: Bool = false) {
        self.shouldError = shouldError
    }
    
    let shouldError: Bool
    
    private let targetingSpecifics = [
        TargetingSpecifics(id: 1, name: "Location", providers: [ProviderPreview(id: 1, name: "Facebook"), ProviderPreview(id: 2, name: "Twitter")]),
        TargetingSpecifics(id: 1, name: "Sex", providers: [ProviderPreview(id: 1, name: "Facebook"), ProviderPreview(id: 2, name: "Instagram")])
    ]
    
    override func fetch() async throws -> [TargetingSpecifics] {
        if shouldError {
            fatalError()
        } else {
            return targetingSpecifics
        }
    }
    
}
