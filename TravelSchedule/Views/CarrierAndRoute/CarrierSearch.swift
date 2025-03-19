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

//#Preview {
//    @State var fromField = "Москва (Ярославский вокзал)"
//    @State var toField = "Санкт-Петербург (Балтийский вокзал)"
//    @State var filterConnectionState: showRouteConnection = .anyConnectionValue
//    @State var travelViewModel = TravelViewModel()
////    var routeSettingViewModel = RouteSettingViewModel(travelViewModel: travelViewModel)
//    let routeCarrierDataModel = RouteCarrierData()
//    CarrierSearch(travelViewModel: travelViewModel)
////    CarrierSearch(routeSettingViewModel: routeSettingViewModel, travelViewModel: travelViewModel)
////    CarrierSearch(fromField: $fromField, toField: $toField)
////    CarrierSearch(fromField: $fromField, toField: $toField, filterConnectionState: $filterConnectionState)
//}
//
//#Preview {
////    @State var filterConnection: showRouteConnection? = .anyConnectionValue
//    var travelViewModel = TravelViewModel()
//    var routeSettingViewModel = RouteSettingViewModel(travelViewModel: travelViewModel)
//    let routeCarrierDataModel = RouteCarrierData()
////    viewModel.filterConnectionState = .noConnections
//    ButtonView(routeSettingViewModel: routeSettingViewModel)
////    ButtonView(routeSettingViewModel: routeSettingViewModel, travelViewModel: travelViewModel)
////    ButtonView(filterConnection: $filterConnection)
//}
//
//#Preview {
//    @State var filterConnection: Bool? = false
//    var routeSettingViewModel: RouteSettingViewModel? = nil
//    var travelViewModel = TravelViewModel()
//    ButtonView(routeSettingViewModel: routeSettingViewModel!)
////    ButtonView(routeSettingViewModel: routeSettingViewModel!, travelViewModel: travelViewModel)
////    ButtonView(filterConnection: $filterConnection)
//}


//    init(travelViewModel: TravelViewModel) {
////    let travelViewModel = TravelViewModel()
////    _travelViewModel = StateObject(wrappedValue: travelViewModel)
//    _routeSettingViewModel = StateObject(wrappedValue: RouteSettingViewModel(travelViewModel: travelViewModel))
////    routeSettingViewModel = RouteSettingViewModel(travelViewModel: travelViewModel)
//    }

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
