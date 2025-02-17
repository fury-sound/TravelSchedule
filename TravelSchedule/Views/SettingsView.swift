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
                //            NavigationStack {
            List {
                    //                    Text("Темная тема")
                    //                        .font(.headline)
                    //                    Text("Пользовательское соглашение")
                    //                        .font(.headline)
                Toggle("Темная тема", isOn: $isDarkMode)
                    .tint(.ypBlueUniversal)
                    .preferredColorScheme(isDarkMode ? .dark : .light)
                    .onChange(of: isDarkMode) { newValue in
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    }
                ZStack(alignment: .leading) {
                    NavigationLink("", value: "")
                        .foregroundStyle(Color.clear, Color.ypBlack)
                    Button("Пользовательское соглашение") {
                        withAnimation {
                            showingUserAgreement = true
                        }
                    }
                        .foregroundStyle(.ypBlack)

                        .fullScreenCover(isPresented: $showingUserAgreement) {
                            userAgreementView()
//                                .transition(.move(edge: .top))
//                                .zIndex(1)
                                .onTapGesture {
                                    showingUserAgreement = false
                                }
                        }
                }
                    //                }
                    //            }
                    //        Spacer()
            }
            Text("Приложение использует API \u{00AB}Яндекс-расписание\u{00BB}")
                .font(.system(size: 12))
                .padding(.bottom, 16)
            Text("Версия 1.0 (beta)")
                .font(.system(size: 12))
        }.padding(.bottom, 24)
    }
}


#Preview {
    SettingsView()
//        .preferredColorScheme(.light)
}
