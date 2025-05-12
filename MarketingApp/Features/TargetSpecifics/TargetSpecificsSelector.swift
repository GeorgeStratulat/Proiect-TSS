//
//  TargetSpecificsSelector.swift
//  MarketingApp
//
//  Created by George Stratulat on 19.05.2024.
//

import SwiftUI

struct TargetSpecificsSelector: View {
    @StateObject private var viewModel = TargetSpecificsViewModel(targetSpecificDA: TargetSpecificsDataAccessor())
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Text("Please select the required targeting specifics:")
                .font(.headline)
            if viewModel.loading {
                ProgressView("Loading")
                    .progressViewStyle(.circular)
                    .accessibilityElement()
                    .accessibilityIdentifier(AccessibilityIdentifiers.loadingIndicator)
            } else {
                if let error = viewModel.error {
                    ErrorBoxView(message: error)
                }
                if viewModel.targetSpecifics.count > 0 {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.targetSpecifics, id: \.self) { item in
                                Text(item.name)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .padding()
                                    .background(
                                        viewModel.selectedTargets.contains(item.id) ? Color.green.opacity(0.5) : Color.gray.opacity(0.5)
                                    )
                                    .cornerRadius(8)
                                    .onTapGesture {
                                        viewModel.selectTarget(id: item.id)
                                    }
                                    .accessibilityElement()
                                    .accessibilityIdentifier(AccessibilityIdentifiers.targetSpecificsItem)
                            }
                        }
                        .padding()
                        .accessibilityIdentifier(AccessibilityIdentifiers.targetSpecificsItemsList)
                    }
                    
                    NavigationLink {
                        ProviderSelector(givenProviders: resultedProviders)
                    } label: {
                        Text("Next")
                            .foregroundColor(resultedProviders.isEmpty ? .gray : .blue)
                    }
                    .disabled(resultedProviders.isEmpty)
                    .accessibilityIdentifier(AccessibilityIdentifiers.nextButton)
                }
                
                
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
    
    private var resultedProviders: [Int] {
        let providers = viewModel.providersForTargetSpecifics()
        if providers.count > 0 {
            return providers.map { $0.id }
        }
        return []
    }
    
    private enum AccessibilityIdentifiers {
        static let targetSpecificView = "targetSpecificView"
        static let loadingIndicator = "loadingIndicator"
        static let targetSpecificsItemsList = "targetSpecificsItemsList"
        static let targetSpecificsItem = "targetSpecificsItem"
        static let nextButton = "nextButton"
    }
    
}

#Preview {
    TargetSpecificsSelector()
}

