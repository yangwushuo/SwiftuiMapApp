//
//  LocationsView.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/14.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    let maxWidthForIpad: CGFloat = 500
    
    var body: some View {
                
        ZStack {
            
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                .padding()
                .frame(maxWidth: maxWidthForIpad)
                
                Spacer()
                    
                locationPreviewStack
                .offset(y: vm.showLocationsList ? 400 : 0)
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
        }
    }
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            Text(vm.mapLocation.name + ",  " + vm.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                    Image(systemName: "arrow.down")
                        .font(.headline)
                        .foregroundColor(.primary)
                        .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                        .padding()
                }
                .background(Color.black.opacity(0.001))
                .asButton(.press) {
                    vm.toggleLocationsList()
                }
            
            if vm.showLocationsList {
                LocationsListView()
            }
            
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius:20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                        .opacity(vm.mapLocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .asButton(.press) {
                            vm.showNextLocation(location: location)
                        }
                }
            }
        )
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(
                        location: location,
                        learnMorePressed: {
                            vm.sheetLocation = location
                        },
                        nextLocationPressed: vm.nextButtonPressed
                    )
                        .shadow(color: .black.opacity(0.5), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)

                }
            }
        }
    }
    
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
