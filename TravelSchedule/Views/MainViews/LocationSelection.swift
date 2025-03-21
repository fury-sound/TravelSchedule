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
    @ObservedObject var travelViewModel: TravelViewModel
    @StateObject var locationSelectionViewModel = LocationSelectionViewModel()

    var body: some View {
        VStack {
            if locationSelectionViewModel.noInternetError == true {
                VStack {
                    NoInternetView()
                }
            } else if locationSelectionViewModel.serverError == true {
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
                        CityListTable(path: $path, searchString: $locationSelectionViewModel.searchString, travelViewModel: travelViewModel)
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

#Preview {
    @State var noInternetError = true
    var settlement = Settlement(id: UUID(), name: "Москва")
    @State var path = [RouteView.stationView(settlement)]
    let travelViewModel = TravelViewModel()
    return LocationSelection(
        headerText: "Выбор города",
        path: $path,
        travelViewModel: travelViewModel
    )
    .environmentObject(travelViewModel)
}
