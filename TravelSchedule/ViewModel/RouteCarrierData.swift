//
//  RouteCarrierData.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 15.02.2025.
//

import SwiftUI

//final class RouteCarrierData: ObservableObject {
final class RouteCarrierData {
//    var travelViewModel: TravelViewModel
//    var selectedRouteArray: [RouteDetailsCarrier] = []
//
//    @MainActor func setRouteArray(travelViewModel: TravelViewModel) {
//        guard !travelViewModel.routeDataList.isEmpty else { return }
//        selectedRouteArray.removeAll()
//        for item in travelViewModel.routeDataList {
//            let duration = String(format: "%.1f", Double(item.duration) / 3600.0)
//            let transferText = item.transfers ? "С пересадкой" : "Прямой"
//            selectedRouteArray.append(RouteDetailsCarrier(
//                id: UUID(),
//                carrier: item.thread.carrier,
//                startDate: item.startDate,
//                departureTime: item.departure,
//                arrivalTime: item.arrival,
//                duration: duration,
//                connection: transferText))
//        }
//    }
}

//    init(travelViewModel: TravelViewModel) {
//        self.travelViewModel = travelViewModel
//    }

//    var dataList = travelViewModel.$routeDataList

//    let carrierRzd: CarrierDetailsMock = CarrierDetailsMock(id: UUID(), name: .rzd, nameLong: "OАO РЖД", imageNameSmall: "rzd")
//    let carrierFgk: CarrierDetailsMock = CarrierDetailsMock(id: UUID(), name: .fgk, nameLong: "OАO ФГК", imageNameSmall: "fgk")
//    let carrierUral: CarrierDetailsMock = CarrierDetailsMock(id: UUID(), name: .uralLogistika, nameLong: "OАO Урал логистика", imageNameSmall: "urallogistic")
//    var mockRouteArray: [RouteDetailsCarrierMock] = []

//    init(travelViewModel: TravelViewModel) {
//        self.travelViewModel = travelViewModel
//    }
//        init() {
//        let route1: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierRzd, date: "14 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
//        let route2: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierFgk, date: "15 января", timeFrom: "01:15", timeTo: "09:00", timeTotal: "9 часов")
//        let route3: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierUral, date: "16 января", timeFrom: "12:30", timeTo: "21:00", timeTotal: "9 часов")
//        let route4: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierRzd, date: "17 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
//        let route5: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierRzd, date: "17 января", timeFrom: "12:30", timeTo: "10:30", timeTotal: "22 часа", connection: "С пересадкой на Северном Полюсе")
//        let route6: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierRzd, date: "17 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
//        let route7: RouteDetailsCarrierMock = RouteDetailsCarrierMock(carrierDetails: carrierRzd, date: "17 января", timeFrom: "12:30", timeTo: "10:30", timeTotal: "22 часа", connection: "С пересадкой на Северном Полюсе")
//        self.mockRouteArray = [route1, route2, route3, route4, route5, route6, route7]
////        self.mockRouteArray = [route1, route2, route3]
//    }

