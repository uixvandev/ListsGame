//
//  ContentView.swift
//  ListsGame
//
//  Created by irfan wahendra on 26/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            GameListView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Profile()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    ContentView()
}
