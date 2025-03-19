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
                    if travelViewModel.isLoading {
                        VStack {
                            ProgressView()
                            Text("Поиск локаций...")
                        }
                    } else {
                        CityListTable(path: $path, searchString: $searchString, travelViewModel: travelViewModel)
                            .font(.system(size: 17, weight: .regular))
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
    @Binding var path: [RouteView]
    @Binding var searchString: String
    @ObservedObject var travelViewModel: TravelViewModel

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
                        NavigationLink(city.name, value: RouteView.stationView(city))
                            .foregroundStyle(.ypBlack, .ypBlack)
                            .simultaneousGesture(TapGesture().onEnded{
                                path.append(.stationView(city))
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
