//
//  File.swift
//  
//
//  Created by Hans Rietmann on 30/06/2021.
//

import Foundation
import SwiftUI




struct SafeAreaGetter: View {
    @Binding var insets: EdgeInsets
    let constantUpdate: Bool
    
    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            if self.insets != .zero, !constantUpdate { return }
            self.insets = geometry.safeAreaInsets
        }

        return Rectangle().fill(Color.clear)
    }
}

extension View {
    public func get(safeArea insets: Binding<EdgeInsets>, constantUpdate: Bool = false) -> some View {
        background(SafeAreaGetter(insets: insets, constantUpdate: constantUpdate))
    }
}
