    //
    //  ContentView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 23.01.2025.
    //

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

struct ContentView: View {
    let travelServices = TravelServices()
    @State private var fromField: String = "Откуда"
    @State private var toField: String = "Куда"
    @State private var whereField: Int = 0

        //    @State private var searchString: String = ""
        //    @Binding var whereField: Int
        //    var whereField: Int
        //    @State var path = NavigationPath()
        //    @State var navModel = NavigationModel()
    @StateObject var navModel = NavigationModel()
        //    @Environment(CityList.self) var cityList

    var body: some View {

        NavigationStack(path: $navModel.path) {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    StoryView()
                }.frame(height: 140)
                    .padding(.bottom, 20)
                FromToView(path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
                    .navigationDestination(for: RouteView.self) { routeView in
                        switch routeView {
                            case .locationView:
                                LocationSelection(headerText: "Выбор города", path: $navModel.path)
                            case .stationView(let city):
                                StationSelection(header: (city, 0), path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
                        }
                    }

                if fromField != "Откуда" && toField != "Куда" {
                    NavigationLink(destination: CarrierSearch(fromField: $fromField, toField: $toField)) {
                        Text("Найти")
                            .font(.system(size: 17, weight: .bold))
                            .padding()
                            .frame(width: 150, height: 60)
                            .background(.ypBlueUniversal)
                            .foregroundStyle(Color.ypWhiteUniversal)
                            .clipShape(.rect(cornerRadius: 16))
                    }
                    .background(Color.clear)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 8)
                }
                Spacer()
            }
            .background(Color.ypWhite)
        }
        .navigationBarBackButtonHidden(true)

        .onAppear() {
            Task {
                    // раскомментировать для запуска соответствующих сервисов
                    //                try betweenStations()
                    //                try stationSchedule()
                    //                try nearestStations()
                    //                try nearestSettlement()
                    //                try carriers()
                    //                try travelServices.showCopyrightInfo()
                    //                try showCopyrightInfo()
                    //                try showStationsOnRoute()
                    //                try showAllStations()
            }
        }
        .background(Color.red)
    }
}

#Preview {
    ContentView()
}


/*

 //        VStack(spacing: 16) {

 //            HStack(alignment: .top) {
 //            }.ignoresSafeArea(.all)
 //            .ignoresSafeArea()
 //            .frame(maxHeight: .infinity)
 //            LazyHStack(alignment: .top, spacing: 5) {
 //            LazyHStack {
 //                .ypBlueUniversal
 //                Rectangle()
 ////                    .frame(width: 92, height: 140)
 //                Rectangle()
 ////                    .frame(width: 92, height: 140)
 //            }.frame(maxHeight: 100)
 //                .background(Color.gray)
 //            Spacer(minLength: 44)
 //            FromToView()
 //            Spacer()

 //                .padding()
 //        }.frame(maxHeight: .infinity, alignment: .top)

 //                FromToView(path: $navModel.path, fromField: $fromField, toField: $toField)
 //                    .navigationDestination(for: RouteFieldStatus.self) { routeStatus in
 //                        switch routeStatus {
 //                            case .from:
 //                                if $navModel.path.isEmpty {
 //                                    LocationSelection(headerText: "Выбор города", path: $navModel.path)
 //                                } else {
 //                                    StationSelection(header: city, path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
 //                                }
 //                            case .to:
 //                        }
 //                    }
 */
