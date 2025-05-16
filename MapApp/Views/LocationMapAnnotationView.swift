//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by mohamed ahmed on 18/04/2025.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    let accentColor = Color.accentColor
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .clipShape(.circle)

            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(accentColor)
                .rotationEffect(.degrees(180))
                .offset(y: -2)
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    LocationMapAnnotationView()
}
