//
//  DoenerSheetViewVM.swift
//  RateYourDoener
//
//  Created by student on 28.06.25.
//

import Foundation

extension DoenerStoreSheetView {
    @Observable
    class ViewModel {
        var store: DoenerStore
        
        let repository: DoenerStoreRepository
        
        init(store: DoenerStore, repository: DoenerStoreRepository) {
            self.store = store
            self.repository = repository
        }
        
        func toggleLogged() {
            store.isLogged.toggle()
        }
    }
}
