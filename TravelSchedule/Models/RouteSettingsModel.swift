//
//  RouteSettingsModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 11.02.2025.
//

import SwiftUI

enum RouteDepartureTime: String, CaseIterable {
//    case anyTime = "any"
    case morning = "06-12"
    case afternoon = "12-18"
    case evening = "18-00"
    case nite = "00-06"
}

enum showRouteConnection: String, CaseIterable {
    case allConnections = "all"
    case noConnections = "no"
    case anyConnectionValue = "any"

    var buttonText: String {
        switch self {
            case .anyConnectionValue: return "Уточнить время"
            case .allConnections: return "Все стыковки"
            case .noConnections: return "Без пересадок"
        }
    }

    var buttonIcon: String {
        switch self {
            case .anyConnectionValue: return ""
            case .allConnections: return "checkmark.circle.fill"
            case .noConnections: return "xmark.circle.fill"
        }
    }

    var shouldShowIcon: Bool {
        self != .anyConnectionValue
    }
}

struct RouteSettingsModel: Hashable {
    let timeSettings: [RouteDepartureTime]
    let filterConnections: showRouteConnection
}
