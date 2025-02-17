    //
    //  StationSelection.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 11.02.2025.
    //

import SwiftUI

struct StationSelection: View {
    var header: (CityList, Int)
        //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var whereField: Int
    @Binding var fromField: String
    @Binding var toField: String    
    @State private var searchString: String = ""
    @State private var noInternetError: Bool = false
    @State private var serverError: Bool = false

        //    @Binding var path: NavigationPath
        //    @ObservedObject var routeData: RouteData
        //    @Binding var directionField: String?

    var body: some View {
        if noInternetError == true {
            VStack {
                NoInternetView()
            }
        } else if serverError == true {
            VStack {
                ServerErrorView()
            }
        } else {
            Text(header.0.cityName)
            VStack {
                SearchBar(searchText: $searchString)
                StationList(city: header, path: $path, whereField: $whereField, fromField: $fromField, toField: $toField, searchString: $searchString)
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
}

struct StationList: View {
    @State var city: (CityList, Int)
        //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var whereField: Int
    @Binding var fromField: String
    @Binding var toField: String
    @Binding var searchString: String
    @State private var stationNames: [String] = []
        //    @EnvironmentObject var routeDirection: RouteDirection
        //    @Binding var path: NavigationPath
        //    @ObservedObject var routeData: RouteData
        //    @State var completion: () -> Void

    var searchResults: [String] {
        if searchString.isEmpty {
            return city.0.stations
        } else {
            return city.0.stations.filter {
                $0.lowercased().contains(searchString.lowercased())
            }
        }
    }
    
    var body: some View {
        let filteredStations = searchResults
        if filteredStations.isEmpty {
            Spacer()
            Text("Станция не найдена")
                .font(.system(size: 24, weight: .bold))
                .padding()
            Spacer()
        } else {
            List {
                    //            ForEach(city.0.stations, id: \.self) { station in
                ForEach(filteredStations, id: \.self) { station in
                    NavigationLink(station, value: station)
                        .foregroundStyle(.ypBlack, .ypBlack)
                        .simultaneousGesture(TapGesture().onEnded{
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

        }
    }
}


#Preview {
        //    @Previewable @EnvironmentObject var routeDirection: RouteDirection
    @Previewable @State var path = [RouteView.stationView(CityList.moscow)]
        //    @Previewable @State var model = NavigationModel() //[RouteView.stationView(CityList.moscow)]
    @Previewable @State var whereField = 0
    @Previewable @State var fromField = ""
    @Previewable @State var toField = ""
        //    @Previewable @State var path = NavigationPath()
    StationSelection(header: (CityList.moscow, 0), path: $path, whereField: $whereField, fromField: $fromField, toField: $toField)
        //    @Previewable @State var routeData = RouteData()
        //    StationSelection(header: CityList.moscow, path: $path, routeData: routeData)
        //    StationSelection()
        //    @Previewable @State var directionField: String? = nil
        //    StationSelection(header: CityList.moscow, directionField: $directionField)
}


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
