//
//  ContentView.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel(repository: DoenerStoreRepository()))
    }
    
    var body: some View {
        NavigationStack {
            Map(initialPosition: .region(viewModel.repository.region)) {
                
                ForEach(viewModel.stores, id: \.self) { store in
                    Annotation(store.mapItem.name!, coordinate: CLLocationCoordinate2D(latitude: store.mapItem.latitude, longitude: store.mapItem.longitude)) {
                        Button {
                            viewModel.selectedStore = store
                            viewModel.showingSheet.toggle()
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(store.isLogged ? .green : .blue)
                                    Text("🥙")
                                }
                            }
                        }
                        
                    }
                }
            }
            .onAppear {
                if viewModel.stores.isEmpty {
                    viewModel.fetchStores()
                }
            }
            .sheet(isPresented: $viewModel.showingSheet) {
                if let store = viewModel.selectedStore {
                    let sheetVM = DoenerStoreSheetView.ViewModel(
                        store: store,
                        repository: viewModel.repository
                    )
                    DoenerStoreSheetView(viewModel: sheetVM)
                }
            }
            .navigationTitle("Rate Your Döner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
