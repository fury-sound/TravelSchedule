    //
    //  StationSelection.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 11.02.2025.
    //

import SwiftUI

struct StationSelection: View {
//    var header: (CityList, Int)
    var header: (Settlement, Int)
        //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var whereField: Int
//    @Binding var fromField: String
//    @Binding var toField: String    
    @State private var searchString: String = ""
    @State private var noInternetError: Bool = false
    @State private var serverError: Bool = false
    @ObservedObject var travelViewModel: TravelViewModel

//    @ObservedObject var travelViewModel: TravelServices

        //    @Binding var path: NavigationPath
        //    @ObservedObject var routeData: RouteData
        //    @Binding var directionField: String?

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
    //            Text(header.0.cityName)
                VStack {
                    SearchBar(searchText: $searchString)
                    StationList(city: header, path: $path, whereField: $whereField, searchString: $searchString, travelViewModel: travelViewModel)
//                    StationList(city: header, path: $path, whereField: $whereField, fromField: $fromField, toField: $toField, searchString: $searchString, travelViewModel: travelViewModel)
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
//            print("city \(header.0)")
            travelViewModel.getStationList(cityName: header.0.name)
        }
    }
}

struct StationList: View {
//    @State var city: (CityList, Int)
    @State var city: (Settlement, Int)
        //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var whereField: Int
//    @Binding var fromField: String
//    @Binding var toField: String
    @Binding var searchString: String
    @State private var stationNames: [String] = []
//    @ObservedObject var travelViewModel: TravelServices
    @ObservedObject var travelViewModel: TravelViewModel

        //    @EnvironmentObject var routeDirection: RouteDirection
        //    @Binding var path: NavigationPath
        //    @ObservedObject var routeData: RouteData
        //    @State var completion: () -> Void

    var searchResults: [Station] {
        travelViewModel.stationSearchFilter(searchString)
//        if searchString.isEmpty {
//            return travelViewModel.travelStationList
//        } else {
//            return travelViewModel.travelStationList.filter {
//                $0.stationName.lowercased().contains(searchString.lowercased())
//            }
//        }
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
//                                travelViewModel.fromField = "\(city.0.name) (\(station.stationName))"
                                travelViewModel.fromField.0 = city.0.name
                                travelViewModel.fromField.1 = station.stationName
                                travelViewModel.fromField.2 = station.codes.yandex_code
//                                print(station.stationType, station.codes)
//                                fromField = "\(city.0.cityName) (\(station))"
                            } else {
//                                travelViewModel.toField = "\(city.0.name) (\(station.stationName))"
                                travelViewModel.toField.0 = city.0.name
                                travelViewModel.toField.1 = station.stationName
                                travelViewModel.toField.2 = station.codes.yandex_code
//                                print(station.stationType, station.codes)
//                                toField = "\(city.0.cityName) (\(station))"
                            }
//                            travelViewModel.travelCityList = []
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


/*
 List {
 ForEach(city.0.stations, id: \.self) { station in
 //                    Text("\(city.cityName), \(station)")
 NavigationLink(station, value: station)
 .foregroundStyle(Color.black, Color.black)
 .simultaneousGesture(TapGesture().onEnded{
 print(path.count)
 print("whereField", whereField)
 //                            print("fromField", model.fromField)
 //                            model.fromField = "\(city.cityName) (\(station))"
 //                            print("fromField", model.fromField)
 //                            if routeDirection.routeFieldStatus == .from {
 if whereField == 0 {
 fromField = "\(city.0.cityName) (\(station))"
 } else {
 toField = "\(city.0.cityName) (\(station))"
 }
 path = []
 })
 }
 .listRowSeparator(.hidden)
 }
 //                    Button(station)
 //                    {
 ////                        routeData.selectedCity = city.cityName
 ////                        routeData.selectedStation = station
 //                        print(path.count)
 //                        print("fromField", fromField)
 //                        fromField = "\(city.cityName) (\(station))"
 //                        print("fromField", fromField)
 //                        path = []
 ////                        path.removeLast(4)
 //                    }

 }
 //                Text("Москва")
 //                Text("Санкт-Петербург")
 //                Text("Новосибирск")
 }
 //            Text("Список станций")
 //        NavigationLink(destination: MoscowTerminal(rawValue: <#String#>)) {
 //            Text("Москва")
 //        }

 //        }


 //func closingView() {
 //    presentationMode.wrappedValue.dismiss()
 //}
 */
