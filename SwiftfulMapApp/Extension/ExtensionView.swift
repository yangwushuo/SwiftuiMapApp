//
//  ExtensionView.swift
//  SwiftfulMapApp
//
//  Created by Jason on 2024/4/17.
//

import Foundation
import SwiftUI

extension View {
    
    public func onTapBlockGesture(count: Int = 1, perform action: @escaping () -> Void) -> some View {
        return self
            .background(Color.black.opacity(0.001))
            .onTapGesture {
                action()
            }
    }

    
}
