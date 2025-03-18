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
    @Published var filteredCarriers: [RouteDetailsCarrier] = []
//    let routeCarrierDataModel: RouteCarrierData
    private var cancellableSet: Set<AnyCancellable> = []
//    lazy var routeCarrierDataModel: RouteCarrierData = {
//        RouteCarrierData()
//    }()

    init() {
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
//                            self.filteredCarriers = travelViewModel.selectedRouteArray
//                            return self.travelViewModel.selectedRouteArray
    //                        return self.routeCarrierDataModel.selectedRouteArray
                        case .noConnections:
    //                        return self.routeCarrierDataModel.selectedRouteArray.filter {
//                            return self.travelViewModel.selectedRouteArray.filter {
//                            self.filteredCarriers = travelViewModel.selectedRouteArray.filter {
                            self.filteredCarriers = CacheStorage.shared.carrierArray.filter {
                                ($0.connection != nil) == false
                            }
                        default:
//                            print("travelViewModel.selectedRouteArray.count", travelViewModel.selectedRouteArray.count)
//                            self.filteredCarriers = travelViewModel.selectedRouteArray
                            self.filteredCarriers = CacheStorage.shared.carrierArray
                            print("filteredCarriers.count", self.filteredCarriers.count)
//                            self.filteredCarriers.forEach { print($0)}
//                            return self.travelViewModel.selectedRouteArray
    //                        return self.routeCarrierDataModel.selectedRouteArray
                    }
                }
//                }
//            .assign(to: \.filteredCarriers, on: self)
            .store(in: &cancellableSet)
    }
}
