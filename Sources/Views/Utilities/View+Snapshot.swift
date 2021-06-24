//
//  File.swift
//  
//
//  Created by Hans Rietmann on 24/06/2021.
//

import Foundation
import SwiftUI




extension View {
    var snapshot: UIImage {
        let controller = UIHostingController(rootView: ignoresSafeArea())
        let view = controller.view

        let targetSize = UIScreen.main.bounds.size
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
