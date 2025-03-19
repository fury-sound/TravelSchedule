//
//  RouteSettingViewModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 03.03.2025.
//

import SwiftUI
import Combine

class RouteSettingViewModel: ObservableObject {
//    private let travelViewModel: TravelViewModel
//    private let initialArray: [RouteDetailsCarrier] = []
//    @Published var routeCarrierDataModel: RouteCarrierData
    @Published var routeDepartureTime: [RouteDepartureTime] = []
    @Published var filterConnectionState: showRouteConnection = .anyConnectionValue
    @Published var isYes: Bool = false
    @Published var isNo: Bool = false
    @Published var isMorning: Bool = false
    @Published var isDay: Bool = false
    @Published var isEvening: Bool = false
    @Published var isNight: Bool = false
    @Published var filteredCarriers: [RouteDetailsCarrier] = []
    @Published var finalFilteredCarriers: [RouteDetailsCarrier] = []
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        self.filteredCarriers = CacheStorage.shared.carrierArray
        self.finalFilteredCarriers = CacheStorage.shared.carrierArray
//    init(travelViewModel: TravelViewModel) {
//    init(initialArray: [RouteDetailsCarrier]) {
//        self.travelViewModel = travelViewModel
//        self.filteredCarriers = initialArray
//        Task { @MainActor in
//            print(self.travelViewModel.selectedRouteArray.count)
////            print(self.travelViewModel.selectedRouteArray[0].startDate, self.travelViewModel.selectedRouteArray[0].carrier.title)
//        }
//        self.routeCarrierDataModel = RouteCarrierData(travelViewModel: TravelViewModel())
//        self.routeCarrierDataModel = RouteCarrierData(travelViewModel: travelViewModel)
//    init() {
//    self.routeCarrierDataModel = RouteCarrierData(travelViewModel: travelViewModel)
//    func setup() {
//        self.filteredCarriers = CacheStorage.shared.carrierArray
        Publishers.CombineLatest($isYes, $isNo)
            .receive(on: RunLoop.main)
            .map { isYes, isNo in
                switch (isYes, isNo) {
                    case (true, false):
                        return .allConnections
                    case (false, true):
                        return .noConnections
                    default:
                        return .anyConnectionValue
                }
            }
            .assign(to: \.filterConnectionState, on: self)
            .store(in: &cancellableSet)

        $filterConnectionState
            .receive(on: RunLoop.main)
//            .map { connectionState in
            .sink { [weak self] connectionState in
                guard let self else { return }
//                Task { @MainActor in
                    switch connectionState {
                        case .allConnections:
                            self.filteredCarriers = CacheStorage.shared.carrierArray
//                            self.filterRoute()
//                            self.filteredCarriers = travelViewModel.selectedRouteArray
//                            return self.travelViewModel.selectedRouteArray
    //                        return self.routeCarrierDataModel.selectedRouteArray
                        case .noConnections:
    //                        return self.routeCarrierDataModel.selectedRouteArray.filter {
//                            return self.travelViewModel.selectedRouteArray.filter {
//                            self.filteredCarriers = travelViewModel.selectedRouteArray.filter {
                            self.filteredCarriers = CacheStorage.shared.carrierArray.filter {
                                ($0.connection != nil) == true
                            }
//                            self.filterRoute()
                        default:
//                            print("travelViewModel.selectedRouteArray.count", travelViewModel.selectedRouteArray.count)
//                            self.filteredCarriers = travelViewModel.selectedRouteArray
                            self.filteredCarriers = CacheStorage.shared.carrierArray
//                            self.filterRoute()
//                            print("filteredCarriers.count", self.filteredCarriers.count)
//                            self.filteredCarriers.forEach { print($0)}
//                            return self.travelViewModel.selectedRouteArray
    //                        return self.routeCarrierDataModel.selectedRouteArray
                    }
                }
//                }
//            .assign(to: \.filteredCarriers, on: self)
            .store(in: &cancellableSet)
    }

    private func checkTimePeriod(_ time: String, isMorning: Bool, isDay: Bool, isEvening: Bool, isNight: Bool) -> Bool {
        let components = time.components(separatedBy: ":")
        guard let hour = Int(components[0]) else { return false }
        if !isMorning && !isDay && !isEvening && !isNight {
            return true
        }
        if isMorning && (hour >= 6 && hour < 12) {
            return true
        } else if isDay && (hour >= 12 && hour < 18) {
            return true
        } else if isEvening && (hour >= 18 || hour == 0) {
            return true
        } else if isNight && (hour >= 0 && hour < 6) {
            return true
        }
        return false
    }

    func filterRoute() {
        finalFilteredCarriers = filteredCarriers.filter { routeData in
            return checkTimePeriod(routeData.departureTime, isMorning: isMorning , isDay: isDay, isEvening: isEvening, isNight: isNight)
        }
//        print("filteredCarriers.count, finalFilteredCarriers.count", filteredCarriers.count, finalFilteredCarriers.count)
    }

}
