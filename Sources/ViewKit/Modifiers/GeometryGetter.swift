//
//  File.swift
//  
//
//  Created by Hans Rietmann on 07/07/2021.
//

import Foundation
import SwiftUI




struct GeometryGetter: View {
    @Binding var geometry: GeometryProxy?
    let constantUpdate: Bool
    
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            guard self.geometry == nil || constantUpdate else { return }
            self.geometry = geometry
        }

        return Rectangle().fill(Color.clear)
    }
}

extension View {
    public func get(geometry: Binding<GeometryProxy?>, constantUpdate: Bool = false) -> some View {
        background(GeometryGetter(geometry: geometry, constantUpdate: constantUpdate))
    }
}
