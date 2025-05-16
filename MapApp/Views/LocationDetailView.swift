//
//  LocationDetailView.swift
//  MapApp
//
//  Created by mohamed ahmed on 19/04/2025.
//

import MapKit
import SwiftUI

// MARK: - LocationDetailView

struct LocationDetailView: View {
    @EnvironmentObject var viewModel: LocationsViewModel

    let location: Location

    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)

                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            backButton
        }
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
}

extension LocationDetailView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(.page)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let url = URL(string: location.link) {
                Link("Read more...", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }

    private var mapLayer: some View {
        Map(position: .constant(.region(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))))) {
            Annotation(location.name, coordinate: location.coordinates) {
                LocationMapAnnotationView()
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(30)
    }

    private var backButton: some View {
        Button {
            viewModel.locationSheet = nil
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(16)
                .background(.thinMaterial)
                .cornerRadius(10)
                .shadow(radius: 4)
                .padding()
        }
    }
}
