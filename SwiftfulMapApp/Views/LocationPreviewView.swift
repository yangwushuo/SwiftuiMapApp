//
//  LocationPreviewView.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/17.
//

import SwiftUI
import SwiftfulUI

struct LocationPreviewView: View {
    
    var location: Location
    var learnMorePressed: (() -> Void)? = nil
    var nextLocationPressed: (() -> Void)? = nil
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: 0) {
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
                .offset(y: 65)
        )
        .cornerRadius(10)
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
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
        Text("Learn more")
            .font(.headline)
            .frame(width: 125, height: 35, alignment: .center)
            .background(.red)
            .foregroundStyle(.white)
            .cornerRadius(8)
            .asButton(.opacity) {
                learnMorePressed?()
            }
        
    }
    
    private var nextButton: some View {
        Text("Next")
            .font(.headline)
            .frame(width: 125, height: 35, alignment: .center)
            .background(.red.opacity(0.1))
            .foregroundStyle(.red)
            .cornerRadius(8)
            .asButton(.opacity) {
                nextLocationPressed?()
            }
    }
    
}

#Preview {
    
    ZStack {
        Color.blue.ignoresSafeArea()
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
    }
}
