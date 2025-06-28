//
//  DoenerStore.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import Foundation
import MapKit

struct DoenerStore: Codable, Hashable {
    var mapItem: CodableMapItem
    
    var isLogged: Bool = false
    var rating: Int?
    var notes: String?
}

struct CodableMapItem: Codable, Equatable, Identifiable, Hashable {
    let id: UUID
    let name: String?
    let latitude: Double
    let longitude: Double
    let phoneNumber: String?
    let url: URL?
    
    init(from mapItem: MKMapItem) {
        self.id          = UUID()
        self.name        = mapItem.name
        self.latitude    = mapItem.placemark.coordinate.latitude
        self.longitude   = mapItem.placemark.coordinate.longitude
        self.phoneNumber = mapItem.phoneNumber
        self.url         = mapItem.url
    }
    
    func mkMapItem() -> MKMapItem {
        let coord   = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let placemark = MKPlacemark(coordinate: coord)
        let item    = MKMapItem(placemark: placemark)
        item.name   = name
        item.phoneNumber = phoneNumber
        item.url    = url
        return item
    }
}
