//
//  Tabbar.swift
//  qsdfghjklm
//
//  Created by Hans Rietmann on 10/06/2021.
//

import SwiftUI



public struct HTab<Content: View>: View {
    
    private let pages: [TabPage]
    @State private var selected: TabPage
    
    public init(@ViewBuilder _ content: @escaping () -> Content) {
        if let tuple2 = content() as? TupleView<(TabPage, TabPage)> {
            pages = [tuple2.value.0, tuple2.value.1]
        } else
        if let tuple3 = content() as? TupleView<(TabPage, TabPage, TabPage)> {
            pages = [tuple3.value.0, tuple3.value.1, tuple3.value.2]
        } else
        if let tuple4 = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage)> {
            pages = [tuple4.value.0, tuple4.value.1, tuple4.value.2, tuple4.value.3]
        } else
        if let tuple5 = content() as? TupleView<(TabPage, TabPage, TabPage, TabPage, TabPage)> {
            pages = [tuple5.value.0, tuple5.value.1, tuple5.value.2, tuple5.value.3, tuple5.value.4]
        } else {
            fatalError("HTab requires a minimum of 2 pages of type 'TabPage' and a maximum of 5 pages.")
        }
        _selected = State(initialValue: pages[0])
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            
            // Content placeholder
            selected
                .content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Tab bar
            Divider()
            HStack {
                Spacer()
                // Tab bar items
                ForEach(pages) { page in
                    Spacer()
                    Button(action: { selected = page }, label: {
                        if page.id == selected.id {
                            page.selected
                        } else {
                            page.deselected
                        }
                    })
                    .font(.title2)
                    .frame(width: 45, height: 55)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}






struct HTab_Previews: PreviewProvider {
    static var previews: some View {
        HTab {
            TabPage(Text("home"))
                .selected { Image(systemName: "house.fill") }
                .deselected { Image(systemName: "house") }
            
            TabPage(Text("search"))
                .selected { Image(systemName: "magnifyingglass").font(.title2.weight(.bold)) }
                .deselected { Image(systemName: "magnifyingglass") }
            
            TabPage(Text("videos"))
                .selected { Image(systemName: "play.rectangle.fill") }
                .deselected { Image(systemName: "play.rectangle") }
            
            TabPage(Text("like"))
                .selected { Image(systemName: "suit.heart.fill") }
                .deselected { Image(systemName: "suit.heart") }
            
            TabPage(Text("account"))
                .selected { Image(systemName: "person.fill") }
                .deselected { Image(systemName: "person") }
        }
        .foregroundColor(.black)
    }
}

