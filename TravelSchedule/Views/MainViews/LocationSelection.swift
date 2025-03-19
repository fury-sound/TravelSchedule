//
//  LocationSelection.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 11.02.2025.
//

import SwiftUI

struct LocationSelection: View {
    var headerText: String
    @Binding var path: [RouteView]
    @State private var searchString: String = ""
    @State private var noInternetError: Bool = false
    @State private var serverError: Bool = false
    @Environment(\.presentationMode) var presentationMode // To dismiss the view
//    @ObservedObject var travelViewModel: TravelServices
    @ObservedObject var travelViewModel: TravelViewModel
//    @ObservedObject var travelServices: TravelServices

    //    @Binding var model: NavigationModel
    //    @Binding var path: NavigationPath
    //    @ObservedObject var routeData: RouteData

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
                    if travelViewModel.isLoading {
                        VStack {
                            ProgressView()
                            Text("Поиск локаций...")
                        }
                    } else {
                        //            SearchBar(searchText: $searchString)
                        CityListTable(path: $path, searchString: $searchString, travelViewModel: travelViewModel)
                        //            CityListTable(path: $path)
                            .font(.system(size: 17, weight: .regular))
                        //                    .transition(.asymmetric(
                        //                        insertion: AnyTransition.scale(scale: 0.1, anchor: .leading).combined(with: .opacity),
                        //                        removal: .move(edge: .trailing)))
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationTitle(headerText).navigationBarTitleDisplayMode(.inline)
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
        .background(Color.ypWhite)
        .onAppear {
//            print("travelViewModel.travelCityList.count in LocationSelection:", travelViewModel.travelCityList.count)
            travelViewModel.travelStationList = []
        }
    }
}


struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        })
        {
            Image(systemName: "chevron.left")
                .foregroundColor(.ypBlack)
        }
    }
}


struct CityListTable: View {
    //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var searchString: String
    //    @State private var cityNames: [CityList] = []
//    @ObservedObject var travelViewModel: TravelServices
    @ObservedObject var travelViewModel: TravelViewModel

    //    @Binding var searchString: String
    //    @Binding var path: NavigationPath
    //    @ObservedObject var routeData: RouteData
    //    @State var cityValue: CityList = CityList()

    //    var searchResults: [CityList] {
    //        if searchString.isEmpty {
    //            return CityList.allCases
    //        } else {
    //            return CityList.allCases.filter {
    //                $0.cityName.lowercased().contains(searchString.lowercased())
    //            }
    //        }
    //    }

    var searchResults: [Settlement] {
        travelViewModel.citySearchFilter(searchString)
    }

    var body: some View {
        VStack {
            SearchBar(searchText: $searchString)
            let filteredCities = searchResults.sorted { $0.name < $1.name }
            if filteredCities.isEmpty {
                Spacer()
                Text("Город не найден")
                    .font(.system(size: 24, weight: .bold))
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(filteredCities, id: \.self) { city in
                        //                if (city.cityName).lowercased.contains(searchString.lowercased()) {
                        //                        NavigationLink(city.cityName, value: RouteView.stationView(city))
                        NavigationLink(city.name, value: RouteView.stationView(city))
                            .foregroundStyle(.ypBlack, .ypBlack)
                            .simultaneousGesture(TapGesture().onEnded{
//                                print("cityName in NavigationLink:", cityName)
                                path.append(.stationView(city))
                                //                                path.append(.stationView(city))
                            })
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding([.top, .bottom], 10)
                }.listStyle(.plain)
            }
        }
    }
}

//#Preview {
//    @State var noInternetError = true
////        @State var path = [RouteView.stationView(CityList.moscow)]
////    @State var path = [RouteView.stationView("Москва")]
//    @State var path = [RouteView.stationView("Москва")]
//    let travelViewModel = TravelServices()
//    LocationSelection(
//        headerText: "Выбор города",
//        path: $path,
//        travelViewModel: travelViewModel
//    )
//}
//
//#Preview {
//    //    @State var path = [RouteView.stationView(CityList.moscow)]
//    @State var path = [RouteView.stationView("Москва")]
//    let travelViewModel = TravelServices()
//    //    @Previewable @State var model = NavigationModel()
//    //    @Previewable @State var model = NavigationPath()
//    //    @Previewable @State var routeData = RouteData()
//    CityListTable(
//        path: $path,
//        searchString: .constant(""),
//        travelViewModel: travelViewModel
//    )
//}
//
//#Preview {
//    @State var path = [RouteView.stationView("Москва")]
//    let travelViewModel = TravelServices()
//    //    @State var path = [RouteView.stationView(CityList.moscow)]
//    //    @Previewable @State var model = NavigationModel()
//    //    @Previewable @State var model = NavigationPath()
//    //    @Previewable @State var routeData = RouteData()
//    LocationSelection(
//        headerText: "Выбор города",
//        path: $path,
//        travelViewModel: travelViewModel
//    )
//}


/*
 ////        NavigationStack {
 //            List(CityList.allCases, id: \.self) { city in
 //                NavigationLink(value: city) {
 //                    Text(city.cityName)
 //                }
 //            }
 //            .navigationDestination(for: CityList.self) { city in
 ////                StationSelection(header: city)
 //                StationSelection()
 ////                NewView()
 //            }.navigationTitle("Список городов")
 //
 ////        }
 //        .font(.system(size: 17, weight: .regular))
 //        .padding([.top, .bottom], 9)

 //        .navigationTitle("")
 List {
 ForEach(CityList.allCases, id: \.self) { city in
 //                Button(action: {
 //                    path.append(.stationView)
 //                }) {
 //                    Text(city.cityName)
 //                        .font(.system(size: 17, weight: .regular))
 //                        .padding([.top, .bottom], 9)
 //                }
 //                .navigationDestination(for: RouteView.self) { route in
 //                    StationSelection(header: city, path: $path)
 ////                    Text("\(route)")
 //                }
 //                NavigationLink(city.cityName, destination: StationSelection(header: city, path: $path))
 NavigationLink(city.cityName, value: RouteView.stationView(city))
 //                    .foregroundStyle(Color.black, Color.red)
 .foregroundStyle(Color.black, Color.black)
 //                    .listItemTint(Color.red)

 .simultaneousGesture(TapGesture().onEnded{
 //                        print("inside SimultaneousGesture")
 //                        print(path)
 //                        print(RouteView.stationView(city))
 path.append(.stationView(city))
 //                        print(model.path, type(of: model.path))
 })

 //                NavigationLink(
 //                    destination:
 //                        StationSelection(header: city, path: $path)
 ////                        StationSelection(header: city, path: $path, routeData: routeData)
 //                    //                        Text(city.cityName)
 //                    //                                            .font(.system(size: 28, weight: .regular))
 //                ) {
 //                    Text("\(city.cityName)")
 //                        .font(.system(size: 17, weight: .regular))
 //                        .padding([.top, .bottom], 9)
 //                }.simultaneousGesture(TapGesture().onEnded{
 //                    print("inside SimultaneousGesture")
 //                    print(path, type(of: path))
 ////                    path.append(.stationView)
 //                })
 */
