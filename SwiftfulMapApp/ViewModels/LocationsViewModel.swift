//
//  LocationsViewModel.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/14.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // all loaded locations
    @Published var locations: [Location] 
    
    // current location on map
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationsList: Bool = false
    
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: self.mapLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation {
            mapRegion = MKCoordinateRegion(center: mapLocation.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationsList() {
        withAnimation {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        withAnimation {
            guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
                return
            }
            
            let nextIndex = currentIndex + 1
            guard locations.indices.contains(nextIndex) else {
                guard let firstLocation = locations.first else { return }
                showNextLocation(location: firstLocation)
                return
            }
            
            showNextLocation(location: locations[nextIndex])
        }
    }

}
