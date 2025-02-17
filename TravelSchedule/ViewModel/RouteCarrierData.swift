//
//  RouteCarrierData.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 15.02.2025.
//

import Foundation

final class RouteCarrierData: ObservableObject {

    let carrierRzd: CarrierDetails = CarrierDetails(id: .rzd, name: "OАO РЖД", imageNameSmall: "rzd")
    let carrierFgk: CarrierDetails = CarrierDetails(id: .fgk, name: "OАO ФГК", imageNameSmall: "fgk")
    let carrierUral: CarrierDetails = CarrierDetails(id: .uralLogistika, name: "OАO Урал логистика", imageNameSmall: "urallogistic")
    var mockRouteArray: [RouteDetailsCarrier] = []

    init() {
        let route1: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierRzd, date: "14 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
        let route2: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierFgk, date: "15 января", timeFrom: "01:15", timeTo: "09:00", timeTotal: "9 часов")
        let route3: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierUral, date: "16 января", timeFrom: "12:30", timeTo: "21:00", timeTotal: "9 часов")
        let route4: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierRzd, date: "17 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
        let route5: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierRzd, date: "17 января", timeFrom: "12:30", timeTo: "10:30", timeTotal: "22 часа", connection: "С пересадкой на Северном Полюсе")
        let route6: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierRzd, date: "17 января", timeFrom: "22:30", timeTo: "08:15", timeTotal: "20 часов", connection: "С пересадкой в Костроме")
        let route7: RouteDetailsCarrier = RouteDetailsCarrier(carrierDetails: carrierRzd, date: "17 января", timeFrom: "12:30", timeTo: "10:30", timeTotal: "22 часа", connection: "С пересадкой на Северном Полюсе")
        self.mockRouteArray = [route1, route2, route3, route4, route5, route6, route7]
//        self.mockRouteArray = [route1, route2, route3]
    }
}
