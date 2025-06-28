//
//  DoenerStoreSheetView.swift
//  RateYourDoener
//
//  Created by student on 27.06.25.
//

import MapKit
import SwiftUI

struct DoenerStoreSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Button(viewModel.store.isLogged ? "Unmark as logged" : "Mark as logged") {
                    viewModel.toggleLogged()
                }
                if viewModel.store.isLogged {
                    Section("Rating") {
                        Stepper("Rating: \(viewModel.store.rating ?? 3)★",
                                value: Binding(
                                    get: { viewModel.store.rating ?? 3 },
                                    set: { viewModel.store.rating = $0 }
                                ), in: 1...5)
                    }
                    Section("Notes") {
                        TextField("Notes", text: Binding(
                            get: { viewModel.store.notes ?? "" },
                            set: { viewModel.store.notes = $0 }
                        ))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .navigationTitle(viewModel.store.mapItem.name ?? "Döner Store")
        }
    }
}
