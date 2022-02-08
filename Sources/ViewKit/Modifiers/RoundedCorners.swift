//
//  RoundedCorners.swift
//  qsdfghjklm
//
//  Created by Hans Rietmann on 11/06/2021.
//

#if !os(macOS)
import SwiftUI


fileprivate struct RoundedCorner: Shape {

    fileprivate var radius: CGFloat = .infinity
    fileprivate var corners: UIRectCorner = .allCorners

    
    fileprivate func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

public extension View {
    func round(corners: UIRectCorner, of radius: CGFloat) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner_Previews: PreviewProvider {
    static var previews: some View {
        Rectangle()
            .round(corners: [.topLeft, .topRight], of: 20)
    }
}
#endif
