    //
    //  SettingsView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import SwiftUI

struct SettingsView: View {
        //    @State private var isFeatureEnabled = false
    @State private var showingUserAgreement: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Toggle("Темная тема", isOn: $isDarkMode)
                        .tint(.ypBlueUniversal)
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                        .onChange(of: isDarkMode) { newValue in
                            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                        }
                        //                ZStack(alignment: .leading) {
                    NavigationLink {
                        userAgreementView()
                    } label: {
                        Text("Пользовательское соглашение")
                            .foregroundStyle(.ypBlack, .ypBlack)
                    }
                    .listRowSeparator(.hidden)
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
        }
    }
}


#Preview {
    SettingsView()
}



    //                    Button("Пользовательское соглашение") {
    ////                        withAnimation {
    //                            showingUserAgreement = true
    ////                        }
    //                    }
    //                        .foregroundStyle(.ypBlack)
    //
    //                        .sheet(isPresented: $showingUserAgreement) {
    //                            userAgreementView()
    ////                                .transition(.move(edge: .top))
    ////                                .zIndex(1)
    //                                .simultaneousGesture(TapGesture().onEnded{
    //                                    showingUserAgreement = false
    //                                })
    ////                                .onTapGesture {
    ////                                    showingUserAgreement = false
    ////                                }
    //                        }
    //                }
    //                }
    //            }
    //        Spacer()
