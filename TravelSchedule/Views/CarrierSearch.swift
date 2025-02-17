    //
    //  CarrierSearch.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

struct CarrierSearch: View {
    @Binding var fromField: String
    @Binding var toField: String
    @StateObject var routeCarrierDataModel = RouteCarrierData()
    @State private var filterConnection: Bool?
    @State private var filterTime: [String] = []
    let screenSize = UIScreen.main.bounds

    var filterResults: [RouteDetailsCarrier] {

            //MARK: тест экрана отсутствия вариантов перевозчика
            //        return []

            //        if filterConnection.isEmpty {
            //            return routeCarrierDataModel.mockRouteArray
            //        }
        switch filterConnection {
            case true:
                return routeCarrierDataModel.mockRouteArray
            case false:
                return routeCarrierDataModel.mockRouteArray.filter {
                    ($0.connection != nil) == false
                }
            default:
                return routeCarrierDataModel.mockRouteArray
        }
    }

    var body: some View {
        VStack {
            Text("\(fromField) \(Image(systemName: "arrow.right")) \(toField)")
                .font(.system(size: 24, weight: .bold))
                .padding(.horizontal, 16)
            ZStack {
                Spacer()
                if filterResults.isEmpty {
                    HStack {
                        Text("Вариантов нет")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.top, -70)
                    }
                } else {
                    VStack {
                        List {
                            ForEach(filterResults, id: \.self) { details in
                                RouteInfo(routeDetailsCarrier: details)
                            }
                            .listRowSeparator(.hidden)
                        }
                        .padding(.vertical, -5)
                        .listStyle(.plain)
                        .ignoresSafeArea(.all)
                    }
                }
                Spacer()
                ButtonView(filterConnection: $filterConnection)
            }
        }
        .toolbarVisibility(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
            //        .onAppear {
            //            print("filterConnection in CarrierSearch", filterConnection)
            //        }
    }
}

struct ButtonView: View {
    @Binding var filterConnection: Bool?

    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: RouteSettings(filterConnection: $filterConnection)) {
                if filterConnection == nil {
                    Text("Уточнить время")
                        .padding(.vertical, 20)
                } else {
                    CustomLabel(text: "Уточнить время", systemImageName: "circle.fill")
                        .padding(.vertical, 20)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundStyle(.white)
            .background(.ypBlueUniversal)
            .clipShape(.rect(cornerRadius: 16))
                //                    .sheet
            .font(.system(size: 17, weight: .bold))
            .padding([.top, .bottom], 10)
            .padding([.leading, .trailing], 16)
                //            .simultaneousGesture(TapGesture().onEnded{
                //                print("filterConnection in ButtonView", filterConnection)
                //            })
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
    @Previewable @State var fromField = "Москва (Ярославский вокзал)"
    @Previewable @State var toField = "Санкт-Петербург (Балтийский вокзал)"
        //    let routeCarrierDataModel = RouteCarrierData()
    CarrierSearch(fromField: $fromField, toField: $toField)
}

#Preview {
    @Previewable @State var filterConnection: Bool? = false
    ButtonView(filterConnection: $filterConnection)
}
