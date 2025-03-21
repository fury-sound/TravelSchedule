    //
    //  ContentViewModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import Foundation



struct Region: Hashable, Sendable {
    var name: String = ""
    var code: String = ""
    var settlements: [Settlement] = []
}

struct Settlement: Hashable, Identifiable, Sendable {
    var id = UUID()
    var name: String = ""
    var code: String = ""
    var stations: [Station] = []
}

struct Station: Hashable, Identifiable, Sendable {
    var id = UUID()
    var stationName: String = ""
    var stationType: String = ""
    var transportType: String = ""
    var codes: StationCode = StationCode()
}

struct StationCode: Hashable, Sendable {
    var express: String = ""
    var yandex: String = ""
    var yandex_code: String = ""
    var esr: String = ""
    var esr_code: String = ""
}

struct Segment: Hashable, Sendable {
    var startDate: String = ""
    var departure: String = ""
    var arrival: String = ""
    var duration: Double = 0.0
    var transfers: Bool = false
    var thread: Thread = Thread()
}

struct Thread: Hashable, Sendable {
    var number: String = ""
    var carrier: Carrier = Carrier()
}

enum RouteView: Hashable {
    case locationView
    case stationView(Settlement)
}

