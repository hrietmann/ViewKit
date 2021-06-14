//
//  RoundedCorners.swift
//  qsdfghjklm
//
//  Created by Hans Rietmann on 11/06/2021.
//

import SwiftUI


fileprivate struct RoundedCorner: Shape {

    fileprivate var radius: CGFloat = .infinity
    fileprivate var corners: UIRectCorner = .allCorners

    
    fileprivate func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

internal extension View {
    func corner(radius: CGFloat, to corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .corner(radius: 20, to: [.topLeft, .topRight])
    }
}
