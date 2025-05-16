//
//  LocationsListView.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var viewModel: LocationsViewModel

    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                Button(action: {
                    viewModel.showNextLocation(location: location)
                }, label: {
                    listRowView(location: location)
                })
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel(locations: LocationsDataService.locations))
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
