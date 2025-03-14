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
    private let travelServices = TravelServices()
    private var cancellables = Set<AnyCancellable>()

init() {
    travelServices.$travelDataAll
        .receive(on: DispatchQueue.main)
        .sink { [weak self] newData in
            self?.travelDataList = newData
            self?.getCityList()
        }
        .store(in: &cancellables)
    }

    func getCityList() {
        for region in travelDataList {
            region.settlements.forEach { settlement in
                if !settlement.name.isEmpty {
                    travelCityList.append(settlement)
                }
            }
        }
        print("travelCityList.count in getCityList", travelCityList.count)
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

    func getTravelData() {
        do {
            try travelServices.showAllStations()
            travelDataList = travelServices.travelDataAll
        } catch {
            print("Ошибка получения данных: \(error.localizedDescription)")
        }
        self.getCityList()
    }
}
