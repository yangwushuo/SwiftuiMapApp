//
//  LocationsListView.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/14.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                listRowView(location: location)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
    
    private func listRowView(location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
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

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
