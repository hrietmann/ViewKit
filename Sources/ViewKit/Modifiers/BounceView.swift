//
//  File.swift
//  
//
//  Created by Hans Rietmann on 30/06/2021.
//

import Foundation
import SwiftUI



struct BounceViewModifier: ViewModifier {
    
    let action: () -> ()
    let scale: CGFloat
    let animation: Animation?
    @State private var isPressed = false
    @State private var frame = CGRect.zero
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? scale:1)
            .gesture(drag)
            .get(frame: $frame, in: .local, constantUpdate: true)
    }
    
    private var drag: some Gesture {
        DragGesture(minimumDistance: 0.0)
            .onChanged { _ in
                guard let animation = animation else { isPressed = true ; return }
                withAnimation(animation) { isPressed = true }
            }
            .onEnded {  _ in
                guard let animation = animation else { isPressed = false ; return }
                withAnimation(animation) { isPressed = false }
            }
            .onEnded { gesture in
                guard frame.contains(gesture.location) else { return }
                action()
            }
        }
}

struct MyBouncyView: View {
    @State private var toggle = false
    
    var body: some View {
        Color.red
            .frame(width: toggle ? 300:150, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(radius: 10)
            .bounceOnTapGesture {
                withAnimation(.spring()) {
                    toggle.toggle()
                }
            }
    }
}

struct BounceView_Preview: PreviewProvider {
    static var previews: some View {
        MyBouncyView()
    }
}


extension View {
    
    @ViewBuilder
    public func bounceOnTapGesture(scale: CGFloat = 0.94, animation: Animation? = .spring(), _ bounce: Bool = true, action: @escaping () -> ()) -> some View {
        if bounce {
            modifier(BounceViewModifier(action: action, scale: scale, animation: animation))
        } else {
            self
        }
    }
}

