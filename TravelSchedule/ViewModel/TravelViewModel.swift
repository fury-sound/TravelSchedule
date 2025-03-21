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
    @Published var isLoading: Bool = false
    private let travelServices = TravelServices()

    func swapFromTo() {
        if fromField.0 != "Откуда" && toField.0 != "Куда" {
            let temp = fromField
            fromField = toField
            toField = temp
        }
    }

    func citySearchFilter(_ searchText: String) -> [Settlement] {
        return searchText.isEmpty ? travelCityList : travelCityList.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func stationSearchFilter(_ searchText: String) -> [Station] {
        return searchText.isEmpty ? travelStationList : travelStationList.filter { $0.stationName.lowercased().contains(searchText.lowercased()) }
    }

    func getCityList() {
        for region in travelDataList {
            region.settlements.forEach { settlement in
                if !settlement.name.isEmpty {
                    travelCityList.append(settlement)
                }
            }
        }
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
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let regions = try await travelServices.showAllStations()
                self.travelDataList = regions
                self.getCityList()
        } catch {
            print("Ошибка получения данных: \(error.localizedDescription)")
        }
    }

    func getRouteData(_ fromCode: String, _ toCode: String) async throws {
        isLoading = true
        defer {
            isLoading = false
        }
        do {
            let segments = try await travelServices.betweenStations(fromCode, toCode)
                self.routeDataList = segments
                self.setRouteArray()
        } catch {
            print("Ошибка получения данных маршрута: \(error.localizedDescription)")
        }
    }

    func setRouteArray() {
        guard !routeDataList.isEmpty else {
            print("Ошибка заполнения списка перевозчиков")
            return
        }
        CacheStorage.shared.carrierArray.removeAll()
        selectedRouteArray.removeAll()
        for item in routeDataList {
            let startDateFormatted = startDateFormatter(item.startDate)
            let departureTimeFormatted = timeFormatter(item.departure)
            let arrivalTimeFormatted = timeFormatter(item.arrival)
            let durationDigit = String(format: "%.0f", Double(item.duration) / 3600.0)
            let durationFormatted = durationDigit + " " + hourToEnding(durationDigit)
            let transferText = item.transfers ? "С пересадкой" : "Прямой"
            selectedRouteArray.append(RouteDetailsCarrier(
                id: UUID(),
                carrier: item.thread.carrier,
                startDate: startDateFormatted,
                departureTime: departureTimeFormatted,
                arrivalTime: arrivalTimeFormatted,
                duration: durationFormatted,
                connection: transferText))
        }
        CacheStorage.shared.carrierArray = selectedRouteArray
    }

    func hourToEnding(_ hours: String) -> String {
        guard let hoursInt = Int(hours) else { return "" }
        let lastDigit = hoursInt % 10
        let lastTwoDigits = hoursInt % 100
        switch (lastTwoDigits, lastDigit) {
            case (11...14, _): return "часов"
            case (_, 1): return "час"
            case (_, 2...4): return "часа"
            default: return "часов"
        }
    }

    func startDateFormatter(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "ru_RU")
        guard let date = inputFormatter.date(from: dateString) else { return "" }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        return outputFormatter.string(from: date)
    }

    func timeFormatter(_ timeString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "HH:mm:ss"
        guard let date = inputFormatter.date(from: timeString) else { return "" }
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "HH:mm"
        return outputFormatter.string(from: date)
    }
}
