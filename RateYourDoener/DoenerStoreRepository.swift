//
//  DoenerStoreRepository.swift
//  RateYourDoener
//
//  Created by student on 28.06.25.
//

import MapKit
import Foundation

@Observable
class DoenerStoreRepository: ObservableObject {
    private(set) var stores: [DoenerStore] = []
    
    private let saveURL = URL.documentsDirectory
        .appendingPathComponent("savedStores.json")
    
    var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.7751759380311, longitude: 6.083487398704785), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    private var queries = ["Döner", "Kebap", "Kebab"]
    
    init() {
        do {
            let data = try Data(contentsOf: saveURL)
            stores = try JSONDecoder().decode([DoenerStore].self, from: data)
        } catch {
            stores = []
        }
    }
    
    func fetch(in region: MKCoordinateRegion) {
        stores.removeAll()
        
        for query in queries {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            request.region = region
            
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let items = response?.mapItems else { return }

                DispatchQueue.main.async {
                    for item in items where !self.stores.contains(where: {
                        $0.mapItem.latitude == item.placemark.coordinate.latitude &&
                        $0.mapItem.longitude == item.placemark.coordinate.longitude
                    }) {
                        self.stores.append(
                            DoenerStore(mapItem: CodableMapItem(from: item))
                        )
                    }
                }
            }
        }
    }
    
    func update(_ updated: DoenerStore) {
            if let idx = stores.firstIndex(where: { $0.mapItem.id == updated.mapItem.id }) {
                stores[idx] = updated
            }
        }
}
