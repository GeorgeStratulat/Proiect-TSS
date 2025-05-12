//
//  TargetSpecificsViewModel.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//

import Foundation
import Combine

final class TargetSpecificsViewModel: ObservableObject {
    private var targetSpecificDA: TargetSpecificsDataAccessor
    
    var task: Task<Void, Error>? = nil
    var cancellables: Set<AnyCancellable> = []
    @Published var targetSpecifics = [TargetingSpecifics]()
    @Published var selectedTargets: Set<Int> = []
    @Published var loading = false
    @Published var error: String? = nil
    
    
    init(targetSpecificDA: TargetSpecificsDataAccessor) {
        self.targetSpecificDA = targetSpecificDA
    }
    
    @MainActor
    func loadData() async {
        self.loading = true
        
        do {
            let targetSpecifics = try await targetSpecificDA.fetch()
            self.targetSpecifics = targetSpecifics
            self.loading = false
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func selectTarget(id: Int) {
        if selectedTargets.contains(id) {
            selectedTargets.remove(id)
        } else {
            selectedTargets.insert(id)
        }
    }
    
    func providersForTargetSpecifics() -> [ProviderPreview] {
        let allProviders = targetSpecifics
            .filter { selectedTargets.contains($0.id) }
            .flatMap { $0.providers }

        let providerCounts = allProviders.reduce(into: [:]) { counts, provider in
            counts[provider, default: 0] += 1
        }

        let commonProviders = providerCounts.filter { $0.value == selectedTargets.count }
        
        return commonProviders.map { $0.key }
    }
}
