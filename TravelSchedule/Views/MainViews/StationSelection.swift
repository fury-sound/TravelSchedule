    //
    //  StationSelection.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 11.02.2025.
    //

import SwiftUI

struct StationSelection: View {
    var header: (Settlement, Int)
    @Binding var path: [RouteView]
    @Binding var whereField: Int
    @State private var searchString: String = ""
    @State private var noInternetError: Bool = false
    @State private var serverError: Bool = false
    @ObservedObject var travelViewModel: TravelViewModel

    var body: some View {
        VStack {
            if noInternetError == true {
                VStack {
                    NoInternetView()
                }
            } else if serverError == true {
                VStack {
                    ServerErrorView()
                }
            } else {
                VStack {
                    SearchBar(searchText: $searchString)
                    StationList(city: header, path: $path, whereField: $whereField, searchString: $searchString, travelViewModel: travelViewModel)
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle("Выбор станции").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButtonView()
                    }
                }
            }
        }
        .background(Color.ypWhite)
        .onAppear() {
            travelViewModel.getStationList(cityName: header.0.name)
        }
    }
}

struct StationList: View {
    @State var city: (Settlement, Int)
    @Binding var path: [RouteView]
    @Binding var whereField: Int
    @Binding var searchString: String
    @State private var stationNames: [String] = []
    @ObservedObject var travelViewModel: TravelViewModel

    var searchResults: [Station] {
        travelViewModel.stationSearchFilter(searchString)
    }
    
    var body: some View {
        let filteredStations = searchResults.sorted { $0.stationName < $1.stationName }
        if filteredStations.isEmpty {
            Spacer()
            Text("Ж/д станция не найдена")
                .font(.system(size: 24, weight: .bold))
                .padding()
            Spacer()
        } else {
            List {
                ForEach(filteredStations, id: \.self) { station in
                    NavigationLink(station.stationName, value: station)
                        .foregroundStyle(.ypBlack, .ypBlack)
                        .simultaneousGesture(TapGesture().onEnded{
                            if whereField == 0 {
                                travelViewModel.fromField.0 = city.0.name
                                travelViewModel.fromField.1 = station.stationName
                                travelViewModel.fromField.2 = station.codes.yandex_code
                            } else {
                                travelViewModel.toField.0 = city.0.name
                                travelViewModel.toField.1 = station.stationName
                                travelViewModel.toField.2 = station.codes.yandex_code
                            }
                            travelViewModel.travelStationList = []
                            path = []
                        })
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .padding([.top, .bottom], 10)
            }
            .listStyle(.plain)
        }
    }
}


//#Preview {
//        //    @Previewable @EnvironmentObject var routeDirection: RouteDirection
////    @State var path = [RouteView.stationView(CityList.moscow)]
//    @State var path = [RouteView.stationView("Москва")]
//        //    @Previewable @State var model = NavigationModel() //[RouteView.stationView(CityList.moscow)]
//    @State var whereField = 0
//    @State var fromField = ""
//    @State var toField = ""
//    let travelViewModel = TravelServices()
//        //    @Previewable @State var path = NavigationPath()
//    StationSelection(header: ("Москва", 0), path: $path, whereField: $whereField, fromField: $fromField, toField: $toField, travelViewModel: travelViewModel)
////    StationSelection(header: (CityList.moscow, 0), path: $path, whereField: $whereField, fromField: $fromField, toField: $toField)
//        //    @Previewable @State var routeData = RouteData()
//        //    StationSelection(header: CityList.moscow, path: $path, routeData: routeData)
//        //    StationSelection()
//        //    @Previewable @State var directionField: String? = nil
//        //    StationSelection(header: CityList.moscow, directionField: $directionField)
//}

