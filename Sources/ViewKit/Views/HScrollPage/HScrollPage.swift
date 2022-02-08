//
//  SwiftUIView.swift
//  
//
//  Created by Hans Rietmann on 22/06/2021.
//

import SwiftUI

public struct HScrollPage<Content: View>: View {
    
    // MARK: - Private Properties
    @State private var currentIndex = 0
    private var pages: [TabPage]
    private let indicator: AnyView?
    private let spacing: CGFloat
    
    public init<Indicator: View>(spacing: CGFloat = 16, indicator: Indicator, @ViewBuilder _ content: @escaping () -> Content) {
        self.spacing = spacing
        self.indicator = AnyView(indicator)
        if let tuple = content() as? TupleView<(TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else {
            fatalError("HTab requires a minimum of 2 pages of type 'TabPage' and a maximum of 10 pages.")
        }
    }
    
    public init(spacing: CGFloat = 16, @ViewBuilder _ content: @escaping () -> Content) {
        self.spacing = spacing
        self.indicator = nil
        if let tuple = content() as? TupleView<(TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else if let tuple = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = Mirror(reflecting: tuple.value).children.compactMap { $0.value as? TabPage }
        } else {
            fatalError("HTab requires a minimum of 2 pages of type 'TabPage' and a maximum of 10 pages.")
        }
    }
    
    // MARK: - Body
    
    public var body: some View {
        VStack(spacing: 0) {
            HScrollHeader(spacing: spacing, indicator: indicator, pages: pages, index: $currentIndex.animation())
            Divider()
            TabView(selection: $currentIndex.animation()) {
                ForEach(0..<pages.count, id: \.self) { index in
                    pages[index]
                        .content
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct HScrollPage_Previews: PreviewProvider {
    static var previews: some View {
        HScrollPage(spacing: 20, indicator: GeometryReader { proxy in
            Color(.label)
                .frame(width: proxy.frame(in: .global).width, height: 4)
                .offset(y: proxy.frame(in: .global).height + 4)
        }) {
            TabPage(Text("Page 1"))
                .selected(Text("Page 1").selected())
                .deselected(Text("Page 1").deselected())

            TabPage(Text("Page 2"))
                .selected(Text("Page 2").selected())
                .deselected(Text("Page 2").deselected())

            TabPage(Text("Page 3"))
                .selected(Text("Page 3").selected())
                .deselected(Text("Page 3").deselected())

            TabPage(Text("Page 4"))
                .selected(Text("Page 4").selected())
                .deselected(Text("Page 4").deselected())

            TabPage(Text("Page 5"))
                .selected(Text("Page 5").selected())
                .deselected(Text("Page 5").deselected())
        }
    }
}

struct TabPageSelected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline, design: .serif).weight(.heavy))
    }
}

struct TabPageDeselected: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline, design: .serif))
    }
}

extension View {
    func selected() -> some View {
        self.modifier(TabPageSelected())
    }
    func deselected() -> some View {
        self.modifier(TabPageDeselected())
    }
}
