//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 09.02.2025.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @StateObject var travelViewModel = TravelViewModel()

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("", systemImage: "arrow.up.message.fill")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ypWhite, for: .tabBar)
                .environmentObject(travelViewModel)
            SettingsView()
                .tabItem {
                    Label("", systemImage: "gearshape.fill")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ypWhite, for: .tabBar)
        }
        .tint(.ypBlack)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainTabView()
}
