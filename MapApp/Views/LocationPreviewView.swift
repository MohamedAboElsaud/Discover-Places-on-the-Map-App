//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import SwiftUI

struct LocationPreviewView: View {
    let location: Location
    @EnvironmentObject var viewModel: LocationsViewModel
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                imageSection

                titleSection
            }
            VStack(spacing: 8) {
                learnMoreButton

                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 70)
        )
        .cornerRadius(10)
    }
}

#Preview {
    ZStack {
        Color.blue.ignoresSafeArea()

        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
    .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var learnMoreButton: some View {
        Button {
            viewModel.locationSheet = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }

    private var nextButton: some View {
        Button {
            viewModel.nextLocationPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.bordered)
    }
}
