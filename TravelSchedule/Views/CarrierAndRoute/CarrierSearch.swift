//
//  CarrierSearch.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 15.02.2025.
//

import SwiftUI

struct CarrierSearch: View {
    @EnvironmentObject var travelViewModel: TravelViewModel
    @ObservedObject var routeSettingViewModel = RouteSettingViewModel()
    @State private var filterTime: [String] = []
    let screenSize = UIScreen.main.bounds

    var body: some View {
        VStack {
            Text("\(travelViewModel.fromField.0) (\(travelViewModel.fromField.1)) \(Image(systemName: "arrow.right")) \(travelViewModel.toField.0) (\(travelViewModel.toField.1))")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
            Spacer()
            ZStack {
                if travelViewModel.isLoading {
                    Spacer()
                    VStack {
                        ProgressView()
                        Text("Поиск перевозчиков...")
                    }
                    Spacer()
                } else if travelViewModel.isLoading == false && travelViewModel.routeDataList.isEmpty {
                    VStack {
                        ServerErrorView()
                        Spacer()
                    }
                } else {
                        if routeSettingViewModel.finalFilteredCarriers.isEmpty {
                            HStack {
                                Text("Вариантов нет")
                                    .font(.system(size: 24, weight: .bold))
                                    .padding(.top, -70)
                            }
                        } else {
                            VStack {
                                List {
                                        ForEach(routeSettingViewModel.finalFilteredCarriers, id: \.self) { details in
                                        ZStack {
                                            RouteInfo(routeDetailsCarrier: details)
                                        }
                                    }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                }
                                .ignoresSafeArea(.all)
                                .padding(.vertical, -5)
                                .padding(.trailing, -18)
                                .foregroundStyle(Color.clear, Color.clear)
                                .listStyle(.plain)
                                .scrollIndicators(.hidden)
                            }
                        }
                        Spacer()
                    ButtonView(routeSettingViewModel: routeSettingViewModel)
                            .environmentObject(travelViewModel)
                }
            }
            .background(Color.ypWhite)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
            }

            if #available(iOS 18.0, *) {
                Text("")
                    .toolbarVisibility(.hidden, for: .tabBar) // for iOS 18.0
            } else {
                Text("")
                    .toolbar(.hidden, for: .tabBar) // deprecated
            }
        }
    }
}

struct ButtonView: View {
    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
    @EnvironmentObject var travelViewModel: TravelViewModel
    @State private var isRouteSettingsViewActive: Bool = false

    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: RouteSettings(routeSettingViewModel: routeSettingViewModel, travelViewModel: travelViewModel, isActive: $isRouteSettingsViewActive)) {
                VStack {
                        if routeSettingViewModel.filterConnectionState == .anyConnectionValue {
                            Text(routeSettingViewModel.filterConnectionState.buttonText)
                                .padding(.vertical, 20)
                        } else {
                            CustomLabel(text: routeSettingViewModel.filterConnectionState.buttonText, systemImageName: routeSettingViewModel.filterConnectionState.buttonIcon)
                                .padding(.vertical, 20)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundStyle(.white)
                .background(.ypBlueUniversal)
                .clipShape(.rect(cornerRadius: 16))
                .font(.system(size: 17, weight: .bold))
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 16)
                .offset(y: isRouteSettingsViewActive ? 0 : 200)
                .opacity(isRouteSettingsViewActive ? 1 : 0)
            }
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: 0.5)) {
                isRouteSettingsViewActive = true
            }
        }

    }
}

struct CustomLabel: View {
    var text: String
    var systemImageName: String

    var body: some View {
        HStack {
            Text(text)
            Image(systemName: systemImageName)
                .foregroundStyle(.ypRed)
        }
    }
}

#Preview {
    @State var filterConnectionState: showRouteConnection = .anyConnectionValue
    var travelViewModel = TravelViewModel()
    travelViewModel.fromField.0 = "Москва"
    travelViewModel.fromField.1 = "Ярославский вокзал"
    travelViewModel.toField.0 = "Санкт-Петербург"
    travelViewModel.toField.1 = "Балтийский вокзал"
    return CarrierSearch()
        .environmentObject(travelViewModel)
}

#Preview {
    var travelViewModel = TravelViewModel()
    var routeSettingViewModel = RouteSettingViewModel()
    return ButtonView(routeSettingViewModel: routeSettingViewModel)
        .environmentObject(travelViewModel)
}
