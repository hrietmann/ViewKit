//
//  File.swift
//  
//
//  Created by Hans Rietmann on 30/06/2021.
//

import Foundation
import SwiftUI


struct TapView: UIViewRepresentable {
    
    @Binding var isPressed: Bool
    let animation: Animation?

    func makeUIView(context: UIViewRepresentableContext<TapView>) -> TapView.UIViewType {
        let view = UIView(frame: .zero)
        let longPress = UILongPressGestureRecognizer(target: context.coordinator,
                                                     action: #selector(Coordinator.press))
        longPress.minimumPressDuration = 0
        view.addGestureRecognizer(longPress)
        return view
    }

    class Coordinator: NSObject {
        var action: () -> ()

        init(_ action: @escaping () -> ()) {
            self.action = action
        }

        @objc func press(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began || gesture.state == .ended {
                action()
            }
        }
    }

    func makeCoordinator() -> TapView.Coordinator {
        return Coordinator {
            guard let animation = animation else { isPressed.toggle() ; return }
            withAnimation(animation) {
                isPressed.toggle()
            }
        }
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<TapView>) {
    }
}

class SingleTouchDownGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .recognized
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .recognized
    }
}

struct BounceView<Content: View>: View {
    
    let scale: CGFloat
    let animation: Animation?
    let content: Content
    @State private var isPressed = false
    
    var body: some View {
        content
            .scaleEffect(isPressed ? scale:1)
            .overlay(TapView(isPressed: $isPressed, animation: animation))
    }
}


struct BounceView_Preview: PreviewProvider {
    static var previews: some View {
        Color.red
            .frame(width: 150, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .shadow(radius: 10)
            .bounceOnTapGesture()
    }
}


extension View {
    
    @ViewBuilder
    public func bounceOnTapGesture(scale: CGFloat = 0.94, animation: Animation? = .spring(), _ bounce: Bool = true) -> some View {
        if bounce {
            BounceView(scale: scale, animation: animation, content: self)
        } else {
            self
        }
    }
}
