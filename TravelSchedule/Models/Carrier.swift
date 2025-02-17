//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 15.02.2025.
//

import Foundation

enum CarrierID: String, CaseIterable {
    case rzd = "РЖД"
    case fgk = "ФГК"
    case uralLogistika = "Урал-логистика"
}

struct CarrierDetails: Identifiable, Hashable {
    var id: CarrierID
    var name: String
    var imageNameSmall: String
    var imageNameLarge: String?
    var email: String?
    var phone: String?
}

struct RouteDetailsCarrier: Hashable {
    var carrierDetails: CarrierDetails
    var date: String
    var timeFrom: String
    var timeTo: String
    var timeTotal: String
    var connection: String?
}
