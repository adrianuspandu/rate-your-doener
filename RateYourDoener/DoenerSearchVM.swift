//
//  DoenerSearchVM.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import Foundation
import MapKit

@Observable
class DoenerSearchVM {
    var stores: [MKMapItem] = []
    
    private var queries = ["Döner", "Kebap", "Kebab"]
    
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
                        $0.placemark.coordinate.latitude == item.placemark.coordinate.latitude &&
                        $0.placemark.coordinate.longitude == item.placemark.coordinate.longitude
                    }) {
                        self.stores.append(item)
                    }
                }
            }
        }
    }
}
