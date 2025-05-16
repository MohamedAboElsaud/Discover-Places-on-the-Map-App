//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var leftAnimationDirection: Bool = true

    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }

    @Published var mapRegion: MapCameraPosition = .region(MKCoordinateRegion())
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    @Published var showLocationList = false
    @Published var locationSheet: Location? = nil
    init(locations: [Location]) {
        self.locations = locations
        mapLocation = locations.first!
        updateMapRegion(location: locations.first!)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinates, span: mapSpan))
        }
    }

    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }

    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }

    func nextLocationPressed() {
        guard let index = locations.firstIndex(of: mapLocation) else { return }
        let nextIndex = (index + 1) % locations.count
        showNextLocation(location: locations[nextIndex])
    }

    func PreviousButtonPressed() {
        // Change animation direction ( <- View )
        leftAnimationDirection = false

        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }

        // Check if the current index is valid
        let previousIndex = currentIndex - 1
        guard locations.indices.contains(previousIndex) else {
            // Previous index is NOT valid
            // Restart from LAST index
            guard let lastLocation = locations.last else { return }
            showNextLocation(location: lastLocation)
            return
        }

        // Next index is valid
        let previousLocation = locations[previousIndex]
        showNextLocation(location: previousLocation)
    }
}
