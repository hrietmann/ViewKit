//
//  File.swift
//  
//
//  Created by Hans Rietmann on 24/06/2021.
//

import Foundation
import SwiftUI



public struct BounceButtonStyle: ButtonStyle {

    let scale: CGFloat
    let animation: Animation?
    @State private var currentScale: CGFloat
    

    public init(scale: CGFloat = 0.93, animation: Animation? = .spring()) {
        self.scale = scale
        self.animation = animation
        _currentScale = State(wrappedValue: 1)
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(currentScale)
            .onChange(of: configuration.isPressed, perform: { value in
                if let animation = animation {
                    withAnimation(animation) {
                        currentScale = value ? scale : 1
                    }
                } else {
                    currentScale = value ? scale : 1
                }
            })
    }
}




extension ButtonStyle {
    
    public static func bounce(scale: CGFloat = 0.93, animation: Animation? = .spring()) -> BounceButtonStyle {
        BounceButtonStyle(scale: scale, animation: animation)
    }
    
}
