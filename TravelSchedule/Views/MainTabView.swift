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

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("", systemImage: "arrow.up.message.fill")
                }
            SettingsView()
                .tabItem {
                    Label("", systemImage: "gearshape.fill")
                }
                .background(Color.green)
        }
        .tint(.ypBlack)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainTabView()
}
