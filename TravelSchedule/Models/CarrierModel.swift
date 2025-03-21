//
//  CarrierModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 21.03.2025.
//

import Foundation

struct RouteDetailsCarrier: Hashable, Identifiable {
    var id: UUID
    var carrier: Carrier
    var startDate: String
    var departureTime: String
    var arrivalTime: String
    var duration: String
    var connection: String?
}

struct Carrier: Hashable, Sendable {
    var title: String = ""
    var email: String = ""
    var phone: String = ""
    var logo: String = ""
    var logo_svg: String = ""
}

