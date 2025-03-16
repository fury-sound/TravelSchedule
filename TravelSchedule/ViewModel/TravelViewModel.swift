//
//  TravelViewModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 14.03.2025.
//

import Foundation
import Combine

@MainActor
final class TravelViewModel: ObservableObject {

    @Published var travelDataList: [Region] = []
    @Published var travelCityList: [Settlement] = []
    @Published var travelStationList: [Station] = []
    @Published var fromField: (String, String, String) = ("Откуда", "", "")
    @Published var toField: (String, String, String) = ("Куда", "", "")
    @Published var routeDataList: [Segment] = []
    @Published var selectedRouteArray: [RouteDetailsCarrier] = []

    //    @Published var fromField: String = "Откуда"
    //    @Published var toField: String = "Куда"
    private let travelServices = TravelServices()
    //    private var cancellables = Set<AnyCancellable>()

    //init() {
    //    travelServices.$travelDataAll
    //        .receive(on: DispatchQueue.main)
    //        .sink { [weak self] newData in
    //            self?.travelDataList = newData
    //            self?.getCityList()
    //        }
    //        .store(in: &cancellables)
    //    }

    func swapFromTo() {
        if fromField.0 != "Откуда" && toField.0 != "Куда" {
            let temp = fromField
            fromField = toField
            toField = temp
        }
    }

    func citySearchFilter(_ searchText: String) -> [Settlement] {
        return searchText.isEmpty ? travelCityList : travelCityList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        //        if searchText.isEmpty {
        //            return travelCityList
        //        } else {
        //        return travelCityList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func stationSearchFilter(_ searchText: String) -> [Station] {
        return searchText.isEmpty ? travelStationList : travelStationList.filter { $0.stationName.lowercased().contains(searchText.lowercased()) }
        //        if searchText.isEmpty {
        //            return travelCityList
        //        } else {
        //        return travelCityList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    //    if searchString.isEmpty {
    //        return travelViewModel.travelStationList
    //    } else {
    //        return travelViewModel.travelStationList.filter {
    //            $0.stationName.lowercased().contains(searchString.lowercased())
    //        }
    //    }

    func getCityList() {
        for region in travelDataList {
            region.settlements.forEach { settlement in
                if !settlement.name.isEmpty {
                    travelCityList.append(settlement)
                }
            }
        }
        //        print("travelCityList.count in getCityList", travelCityList.count)
    }

    func getStationList(cityName: String) {
        let settlementToSearch = travelCityList.filter { $0.name == cityName }
        settlementToSearch.forEach { settlement in
            settlement.stations.forEach { station in
                if station.transportType == "train" && !station.codes.yandex_code.isEmpty {
                    travelStationList.append(station)
                }
            }
        }
    }

    func getTravelData() async {
        do {
            let regions = try await travelServices.showAllStations()
            await MainActor.run {
                self.travelDataList = regions
                //                print("travelDataList.count", travelDataList.count)
                self.getCityList()
            }
        } catch {
            print("Ошибка получения данных: \(error.localizedDescription)")
        }
    }

    //    func getRouteData(_ fromCode: String = "s9602494", _ toCode: String = "s9623135") async {
    func getRouteData(_ fromCode: String, _ toCode: String) async {
        //        print("in getRouteData, fromCode: \(fromCode), toCode: \(toCode)")
        do {
            //            try await travelServices.betweenStations(fromCode, toCode)
            let segments = try await travelServices.betweenStations(fromCode, toCode)
            await MainActor.run {
                print("in getRouteData, fromCode: \(fromCode), toCode: \(toCode)")
                self.routeDataList = segments
                print("routeData.count", segments.count)
                print("routeDataList.count", routeDataList.count)
                self.setRouteArray()
            }
        } catch {
            print("Ошибка получения данных маршрута: \(error.localizedDescription)")
        }
    }

    func setRouteArray() {
        print("1. routeDataList", routeDataList.count)
        guard !routeDataList.isEmpty else {
            print("Ошибка заполнения списка перевозчиков")
            return
        }
        selectedRouteArray.removeAll()
        for item in routeDataList {
            let duration = String(format: "%.1f", Double(item.duration) / 3600.0)
            let transferText = item.transfers ? "С пересадкой" : "Прямой"
            selectedRouteArray.append(RouteDetailsCarrier(
                carrier: item.thread.carrier,
                startDate: item.startDate,
                departureTime: item.departure,
                arrivalTime: item.arrival,
                duration: duration,
                connection: transferText))
        }
        print("2. selectedRouteArray", selectedRouteArray.count)
        print(selectedRouteArray[0].startDate, selectedRouteArray[0].carrier.title)
    }
}
