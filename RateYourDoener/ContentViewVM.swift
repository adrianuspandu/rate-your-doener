//
//  ContentViewVM.swift
//  RateYourDoener
//
//  Created by student on 28.06.25.
//

import CoreLocation
import MapKit
import Foundation

extension ContentView {
    @Observable
    class ViewModel: ObservableObject {
        var selectedStore: DoenerStore?
        var showingSheet = false
        
        let repository: DoenerStoreRepository
        
        var stores: [DoenerStore] {
            repository.stores
        }
        
        init(repository: DoenerStoreRepository) {
            self.repository = repository
        }
        
        func fetchStores() {
            if repository.stores.isEmpty {
                repository.fetch(in: repository.region)
            }
        }
    }

}
