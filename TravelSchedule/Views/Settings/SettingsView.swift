    //
    //  SettingsView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State private var showTabBar: Bool = true

    var body: some View {
            NavigationStack {
                VStack {
                    List {
                        Toggle("Темная тема", isOn: $isDarkMode)
                            .tint(.ypBlueUniversal)
                            .preferredColorScheme(isDarkMode ? .dark : .light)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        NavigationLink {
                            userAgreementView(isDarkMode: $isDarkMode, showTabBar: $showTabBar)
                        } label: {
                            Text("Пользовательское соглашение")
                        }
                        .opacity(showTabBar ? 1 : 0)
                        .animation(.easeInOut(duration: 0.3), value: showTabBar)
                        .listRowSeparator(.hidden)
                        .foregroundStyle(.ypBlack, .ypBlack)
                        .listRowBackground(Color.clear)

                        if #available(iOS 18.0, *) {
                            Text("")
                                .backgroundStyle(Color.clear)
                                .foregroundStyle(.clear, .clear)
                                .listRowBackground(Color.clear)
                                .hidden()
                                .listRowSeparator(.hidden)
                                .toolbarVisibility(showTabBar ? .visible : .hidden, for: .tabBar) // for iOS 18.0
                        } else {
                            Text("")
                                .backgroundStyle(Color.clear)
                                .foregroundStyle(.clear, .clear)
                                .listRowBackground(Color.clear)
                                .hidden()
                                .listRowSeparator(.hidden)
                                .toolbar(showTabBar ? .visible : .hidden, for: .tabBar) // deprecated
                        }
                    }
                    .padding(16)
                    .listStyle(.plain)
                    Text("Приложение использует API \u{00AB}Яндекс-расписание\u{00BB}")
                        .font(.system(size: 12))
                        .padding(.bottom, 16)
                    Text("Версия 1.0 (beta)")
                        .font(.system(size: 12))
                        .padding(.bottom, 24)
                }
                .background(Color.ypWhite)
            }
    }
}

#Preview {
    SettingsView()
}

