//
//  SwiftUIView.swift
//  
//
//  Created by Hans Rietmann on 14/06/2021.
//

import SwiftUI

public struct TabPage: View, Identifiable {
    
    public let id = UUID()
    internal let content: AnyView
    internal var selected: AnyView
    internal var deselected: AnyView
    
    public init<Content: View>(@ViewBuilder _ content: () -> Content) {
        self.content = AnyView(content())
        selected = AnyView(Image(systemName: "house.fill"))
        deselected = AnyView(Image(systemName: "house"))
    }
    
    public init<Content: View>(_ content: Content) {
        self.content = AnyView(content)
        selected = AnyView(Image(systemName: "house.fill"))
        deselected = AnyView(Image(systemName: "house"))
    }
    
    public var body: some View {
        content
    }
    
    public func selected<V: View>(@ViewBuilder _ label: @escaping () -> V) -> TabPage {
        var page = self
        page.selected = AnyView(label())
        return page
    }
    
    public func selected<V: View>(_ label: V) -> TabPage {
        var page = self
        page.selected = AnyView(label)
        return page
    }
    
    public func deselected<V: View>(@ViewBuilder _ label: @escaping () -> V) -> TabPage {
        var page = self
        page.deselected = AnyView(label())
        return page
    }
    
    public func deselected<V: View>(_ label: V) -> TabPage {
        var page = self
        page.deselected = AnyView(label)
        return page
    }
    
}

struct TabPage_Previews: PreviewProvider {
    static var previews: some View {
        TabPage(Text("home"))
            .selected { Image(systemName: "house.fill") }
            .deselected { Image(systemName: "house") }
    }
}
