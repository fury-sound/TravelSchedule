    //
    //  CarrierSearch.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

struct CarrierSearch: View {
    @ObservedObject var routeSettingViewModel = RouteSettingViewModel()
    @Binding var fromField: String
    @Binding var toField: String
//    @StateObject var routeCarrierDataModel = RouteCarrierData()
//    @State private var filterConnection: Bool?
//    @Binding var filterConnectionState: showRouteConnection
    @State private var filterTime: [String] = []
    let screenSize = UIScreen.main.bounds

//    var filterResults: [RouteDetailsCarrier] {
//
//            //MARK: тест экрана отсутствия вариантов перевозчика
//            //        return []
//
//            //        if filterConnection.isEmpty {
//            //            return routeCarrierDataModel.mockRouteArray
//            //        }
////        switch filterConnection {
////            case true:
////                return routeCarrierDataModel.mockRouteArray
////            case false:
////                return routeCarrierDataModel.mockRouteArray.filter {
////                    ($0.connection != nil) == false
////                }
////            default:
////                return routeCarrierDataModel.mockRouteArray
////        }
//
////        print("in filterResults")
////        print("routeSettingViewModel.filterConnection: \(routeSettingViewModel.filterConnectionState)")
//        switch routeSettingViewModel.filterConnectionState {
//            case .allConnections:
//                return routeCarrierDataModel.mockRouteArray
//            case .noConnections:
//                return routeCarrierDataModel.mockRouteArray.filter {
//                    ($0.connection != nil) == false
//                }
//            default:
//                return routeCarrierDataModel.mockRouteArray
//        }
//    }

    var body: some View {
        VStack {
            Text("\(fromField) \(Image(systemName: "arrow.right")) \(toField)")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
            ZStack {
                Spacer()
//                if filterResults.isEmpty {
                if routeSettingViewModel.filteredCarriers.isEmpty {
                    HStack {
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.top, -70)
                    }
                } else {
                    VStack {
                        List {
//                            ForEach(filterResults, id: \.self) { details in
                            ForEach(routeSettingViewModel.filteredCarriers, id: \.self) { details in
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

struct ButtonView: View {
    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
//    @Binding var filterConnection: Bool?
//    @Binding var filterConnectionState: showRouteConnection
    @State private var isRouteSettingsViewActive: Bool = false

    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: RouteSettings(viewModel: routeSettingViewModel, isActive: $isRouteSettingsViewActive)) {
            VStack {
                if routeSettingViewModel.filterConnectionState == .anyConnectionValue {
//                    Text("Уточнить время")
                    Text(routeSettingViewModel.filterConnectionState.buttonText)
//                    CustomLabel(
//                        text: routeSettingViewModel.filterConnectionState.buttonText,
//                        systemImageName: routeSettingViewModel.filterConnectionState.buttonIcon
//                    )
                        .padding(.vertical, 20)
                } else {
//                    Text(routeSettingViewModel.filterConnectionState.buttonText)
//                    CustomLabel(text: "Уточнить время", systemImageName: "circle.fill")
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
//            Text("Values: \(filterConnectionState.rawValue)")
//            Text("Values: \(routeSettingViewModel.filterConnectionState.rawValue)")
        }
        .onAppear(){
            withAnimation(.easeInOut(duration: 0.5)) {
                isRouteSettingsViewActive = true
//                routeSettingViewModel.filterConnectionState = .noConnections
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
    @State var fromField = "Москва (Ярославский вокзал)"
    @State var toField = "Санкт-Петербург (Балтийский вокзал)"
    @State var filterConnectionState: showRouteConnection = .anyConnectionValue
        //    let routeCarrierDataModel = RouteCarrierData()
    CarrierSearch(fromField: $fromField, toField: $toField)
//    CarrierSearch(fromField: $fromField, toField: $toField, filterConnectionState: $filterConnectionState)
}

#Preview {
//    @State var filterConnection: showRouteConnection? = .anyConnectionValue
    var viewModel = RouteSettingViewModel()
//    viewModel.filterConnectionState = .noConnections
    ButtonView(routeSettingViewModel: viewModel)
//    ButtonView(filterConnection: $filterConnection)
}

#Preview {
    @State var filterConnection: Bool? = false
    var routeSettingViewModel: RouteSettingViewModel? = nil
    ButtonView(routeSettingViewModel: routeSettingViewModel!)
//    ButtonView(filterConnection: $filterConnection)
}
