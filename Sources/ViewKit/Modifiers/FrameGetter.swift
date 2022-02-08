//
//  File.swift
//  
//
//  Created by Hans Rietmann on 23/06/2021.
//

import Foundation
import SwiftUI




struct FrameGetter: View {
    @Binding var rect: CGRect
    let space: CoordinateSpace
    let constantUpdate: Bool
    
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            if self.rect != .zero, !constantUpdate { return }
            self.rect = geometry.frame(in: space)
        }

        return Rectangle().fill(Color.clear)
    }
}

extension View {
    public func get(frame: Binding<CGRect>, in space: CoordinateSpace = .global, constantUpdate: Bool = false) -> some View {
        background(FrameGetter(rect: frame, space: space, constantUpdate: constantUpdate))
    }
}
