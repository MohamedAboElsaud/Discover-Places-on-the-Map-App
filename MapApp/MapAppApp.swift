//
//  MapAppApp.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject private var viewModel = LocationsViewModel(locations: LocationsDataService.locations)

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
