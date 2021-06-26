//
//  SwiftUIView.swift
//  
//
//  Created by Hans Rietmann on 26/06/2021.
//

import SwiftUI

public struct ChatBubble<Content>: View where Content: View {
    let direction: ChatBubbleShape.Direction
    let content: () -> Content
    
    public init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
            self.content = content
            self.direction = direction
    }
    
    public var body: some View {
        HStack {
            if direction == .right {
                Spacer()
            }
            content().clipShape(ChatBubbleShape(direction: direction))
            if direction == .left {
                Spacer()
            }
        }
        .padding([(direction == .left) ? .leading : .trailing])
        .padding((direction == .right) ? .leading : .trailing, 60)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack() {
                ChatBubble(direction: .left) {
                            Text("Hello!")
                                .padding()
                                .background(Color(.secondarySystemFill))
                        }
                        ChatBubble(direction: .right) {
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse ut semper quam. Phasellus non mauris sem. Donec sed fermentum eros. Donec pretium nec turpis a semper. ")
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.blue)
                        }
                    }
                }
    }
}
