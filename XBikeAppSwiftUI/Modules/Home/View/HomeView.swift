//
//  HomeView.swift
//  XBikeAppSwiftUI
//
//  Created by alex on 26/03/25.
//

import SwiftUI

struct HomeView: View {
    let appearance: UITabBarAppearance = UITabBarAppearance()
    
    init() {
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.orangeOne)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.orangeOne)]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            CurrentRideView()
            .tabItem {
                Label("Current Ride", systemImage: "speedometer")
            }
            MyProgressView()
            .tabItem {
                Label("My Progress", systemImage: "tray.full")
            }
        }
    }
}
