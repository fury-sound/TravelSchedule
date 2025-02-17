//
//  MainTabView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 09.02.2025.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Journal", systemImage: "arrow.up.message.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .tint(.ypBlack)
    }
}

#Preview {
    MainTabView()
}
