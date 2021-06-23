//
//  SwiftUIView.swift
//  
//
//  Created by Hans Rietmann on 23/06/2021.
//

import SwiftUI

struct HScrollHeader: View {
    
    // MARK: - Public Properties
    
    private let spacing: CGFloat
    private let indicator: AnyView?
    private let pages: [TabPage]
    @Binding var currentIndex: Int
    @State private var compactHStackFrame: CGRect = .zero
    @State private var currentPageFrame: CGRect = .zero
    
    
    init<Indicator: View>(spacing: CGFloat, indicator: Indicator? = nil, pages: [TabPage], index: Binding<Int>) {
        self.spacing = spacing
        if let indicator = indicator {
            self.indicator = AnyView(indicator)
        } else {
            self.indicator = nil
        }
        self.pages = pages
        _currentIndex = index
    }
    
    
    var body: some View {
        HStack {
            if compactHStackFrame.width == 0 {
                compactHStack
                    .fixedSize()
                    .get(frame: $compactHStackFrame)
            } else if compactHStackFrame.width < UIScreen.main.bounds.width {
                largeHStack
            } else {
                scroll
            }
        }
        .foregroundColor(Color(.label))
        .frame(height: 60)
    }
    
    var largeHStack: some View {
        HStack(spacing: spacing) {
            ForEach(0..<pages.count) { index in
                Button(action: {
                    withAnimation {
                        currentIndex = index
                    }
                }, label: {
                    if index == currentIndex {
                        pages[index]
                            .selected
                            .get(frame: $currentPageFrame.animation(.spring()),
                                 in: .named("HScrollHeader.LargeHStack"),
                                 constantUpdate: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.identity.combined(with: .opacity))
                    } else {
                        pages[index]
                            .deselected
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .transition(.identity.combined(with: .opacity))
                    }
                })
                .padding(.horizontal, spacing)
                .id(index)
            }
        }
        .background(indicatorBackground)
        .coordinateSpace(name: "HScrollHeader.LargeHStack")
    }
    
    @ViewBuilder
    var indicatorBackground: some View {
        if let indicator = indicator {
            indicator
                .frame(width: currentPageFrame.width, height: currentPageFrame.height)
                .offset(x: currentPageFrame.minX, y: 0)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            EmptyView()
        }
    }
    
    var compactHStack: some View {
        HStack(spacing: spacing) {
            ForEach(0..<pages.count, content: compactButton)
        }
        .background(indicatorBackground)
        .coordinateSpace(name: "HScrollHeader.CompactHStack")
    }
    
    func compactButton(_ index: Int) -> some View {
        Button(action: {
            withAnimation {
                currentIndex = index
            }
        }, label: {
            if index == currentIndex {
                pages[index]
                    .selected
                    .get(frame: $currentPageFrame.animation(.spring()),
                         in: .named("HScrollHeader.CompactHStack"),
                         constantUpdate: true)
                    .lineLimit(1)
                    .padding(.horizontal, spacing)
                    .frame(maxHeight: .infinity)
                    .transition(.identity)
            } else {
                pages[index]
                    .deselected
                    .lineLimit(1)
                    .padding(.horizontal, spacing)
                    .frame(maxHeight: .infinity)
                    .transition(.identity)
            }
        })
        .id(index)
        .animation(.spring())
        .padding(.leading, index == 0 ? spacing : 0)
        .padding(.trailing, index == pages.count - 1 ? spacing : 0)
    }
    
    var scroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scroll in
                compactHStack
                    .onChange(of: currentIndex, perform: { value in
                        withAnimation {
                            scroll.scrollTo(value, anchor: value == 0 ? .leading:value == pages.endIndex ? .trailing:nil)
                        }
                    })
            }
        }
    }
    
    
    // MARK: - Private Methods
    
    func shouldShowIndex(_ index: Int) -> Bool {
        ((currentIndex - 1)...(currentIndex + 1)).contains(index)
    }
}

struct HScrollHeader_Previews: PreviewProvider {
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
