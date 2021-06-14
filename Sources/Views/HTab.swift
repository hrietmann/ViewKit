//
//  Tabbar.swift
//  qsdfghjklm
//
//  Created by Hans Rietmann on 10/06/2021.
//

import SwiftUI

public struct HTab: View {
    
    private let items: [HTab.Item]
    @State private var selected: HTab.Item
    
    public init(_ tabs: HTab.Item...) {
        _selected = State(initialValue: tabs[0])
        items = tabs
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            selected.page
                .frame(maxHeight: .infinity)
            Divider()
            HStack {
                Spacer()
                ForEach(items) { item in
                    Spacer()
                    Button(action: { selected = item }) {
                        if selected.id == item.id {
                            item.selected
                        } else {
                            item.deselected
                        }
                    }
                    .frame(width: 55, height: 55)
//                    .background(Color.blue)
                    Spacer()
                }
                Spacer()
            }
            .font(.title3)
        }
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


extension HTab {
    public struct Item: Identifiable {
        public let id = UUID()
        let selected: AnyView
        let deselected: AnyView
        let page: AnyView
        
        
        public init<Selected:View, Deselected: View, Page:View>(selected: Selected, deselected: Deselected, page: Page) {
            self.selected = AnyView(selected)
            self.deselected = AnyView(deselected)
            self.page = AnyView(page)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HTab(
            HTab.Item(selected: Image(systemName: "house.fill"),
                          deselected: Image(systemName: "house"),
                          page: NavigationView {
                            NavigationLink("Go to hello", destination: Text("Hello world !"))
                                .navigationTitle("Home")
                        }),
            HTab.Item(selected: Image(systemName: "magnifyingglass").font(Font.title2.weight(.bold)),
                          deselected: Image(systemName: "magnifyingglass"),
                          page: Text("Search")),
            HTab.Item(selected: Image(systemName: "play.rectangle.fill"),
                          deselected: Image(systemName: "play.rectangle"),
                          page: Text("Videos")),
            HTab.Item(selected: Image(systemName: "suit.heart.fill"),
                          deselected: Image(systemName: "suit.heart"),
                          page: Text("Notifications")),
            HTab.Item(selected: Image("User.current.profileImageName")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .clipShape(Circle()),
                          deselected: Image("User.current.profileImageName")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                            .clipShape(Circle()),
                          page: Text("Account"))
        )
            .foregroundColor(Color(.label))
    }
}
