//
//  Tabbar.swift
//  qsdfghjklm
//
//  Created by Hans Rietmann on 10/06/2021.
//

import SwiftUI

public struct HomeView: View {
    
    private let items: [HomeView.Item]
    @State private var selected: HomeView.Item
    
    public init(_ tabs: HomeView.Item...) {
        _selected = State(initialValue: tabs[0])
        items = tabs
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            selected.page
                .frame(maxHeight: .infinity)
            Divider()
            HStack {
                ForEach(items) { item in
                    Button(action: { selected = item }) {
                        if selected.id == item.id {
                            item.selected
                        } else {
                            item.deselected
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .frame(height: 55)
            .font(.title3)
            .padding(.horizontal)
        }
        .ignoresSafeArea(.all, edges: .top)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


extension HomeView {
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
        HomeView(
            HomeView.Item(
                selected: Image(systemName: "house.fill"),
                deselected: Image(systemName: "house"),
                page: NavigationView {
            NavigationLink("Go to hello", destination: Text("Hello world !"))
                .navigationTitle("Home")
        }),
            HomeView.Item(
                selected: Image(systemName: "suit.heart.fill"),
                deselected: Image(systemName: "suit.heart"),
                page: Text("Notifications")),
            HomeView.Item(
                selected: Image(systemName: "star.fill"),
                deselected: Image(systemName: "star"),
                page: Text("Hello Bonbon bulle !")),
            HomeView.Item(
                selected: Image(systemName: "person.fill"),
                deselected: Image(systemName: "person").font(.title),
                page: Text("Hello Bonbon bulle !"))
        )
            .foregroundColor(.black)
    }
}
