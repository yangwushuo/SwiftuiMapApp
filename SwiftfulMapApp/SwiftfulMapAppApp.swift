//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/13.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
