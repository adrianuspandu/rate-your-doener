//
//  ContentView.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var searchVM = DoenerSearchVM()
    
    @State private var selectedStore: MKMapItem?
    @State private var showingSheet = false
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.7751759380311, longitude: 6.083487398704785), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var body: some View {
        NavigationStack {
            Map(initialPosition: .region(region)) {
                
                ForEach(searchVM.stores, id: \.self) { store in
                    Annotation(store.placemark.name!, coordinate: store.placemark.coordinate) {
                        Button {
                            selectedStore = store
                        } label: {
                            VStack {
                                ZStack {
                                    Circle()
                                        .frame(width: 44, height: 44)
                                        .foregroundColor(.red)
                                    Text("🥙")
                                }
                            }
                        }
                        
                    }
                }
            }
            .onAppear {
                searchVM.fetch(in: region)
            }
            .navigationTitle("Rate Your Döner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
