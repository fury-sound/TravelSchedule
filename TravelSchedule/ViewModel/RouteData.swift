//
//  RouteData.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 12.02.2025.
//

import SwiftUI

final class RouteData: ObservableObject {
    @Published var selectedCity: String = ""
    @Published var selectedStation: String = ""
}
