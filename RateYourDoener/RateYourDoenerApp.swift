//
//  RateYourDoenerApp.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import SwiftUI

@main
struct RateYourDoenerApp: App {
    @StateObject var repository = DoenerStoreRepository()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(repository)
        }
    }
}
