//
//  RouteSettingViewModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 03.03.2025.
//

import SwiftUI
import Combine

class RouteSettingViewModel: ObservableObject {
//    @ObservedObject var routeCarrierDataModel = RouteCarrierData()

    @Published var routeDepartureTime: [RouteDepartureTime] = []
    @Published var filterConnectionState: showRouteConnection = .anyConnectionValue
    @Published var isYes: Bool = false
    @Published var isNo: Bool = false
    @Published var filteredCarriers: [RouteDetailsCarrier] = []
    let routeCarrierDataModel = RouteCarrierData()
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
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
            .map { connectionState in
                switch connectionState {
                    case .allConnections:
                        return self.routeCarrierDataModel.mockRouteArray
                    case .noConnections:
                        return self.routeCarrierDataModel.mockRouteArray.filter {
                            ($0.connection != nil) == false
                        }
                    default:
                        return self.routeCarrierDataModel.mockRouteArray
                }
            }
            .assign(to: \.filteredCarriers, on: self)
            .store(in: &cancellableSet)
    }
}
