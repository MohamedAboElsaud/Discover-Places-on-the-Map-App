//
//  LocationsView.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import MapKit
import SwiftUI

struct LocationsView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel
    let maxWidthForIpad: CGFloat = 700

    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()

            VStack {
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)

                Spacer()

                locationsPreviewStack
            }
        }
        .sheet(item: $viewModel.locationSheet, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
        
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button {
                viewModel.toggleLocationList()
            } label: {
                Text("\(viewModel.mapLocation.name), \(viewModel.mapLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: viewModel.showLocationList ? 180 : 0))
                    }
            }

            if viewModel.showLocationList {
                LocationsListView()
            }
        }
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
    }

    private var mapLayer: some View {
        Map(position: $viewModel.mapRegion) {
            ForEach(viewModel.locations) { location in
                Annotation(location.name, coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            viewModel.showNextLocation(location: location)
                        }
                }
            }
        }
    }

    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if location == viewModel.mapLocation {
                    LocationPreviewView(location: viewModel.mapLocation)
                        .shadow(color: .black.opacity(0.3), radius: 30)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(
                            //  AnyTransition.scale.animation(.easeInOut)
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                }
            }
        }
    }
}
