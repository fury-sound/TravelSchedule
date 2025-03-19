//
//  NavigationModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 12.02.2025.
//

import SwiftUI

enum RouteFieldStatus {
    case from
    case to
}

final class NavigationModel: ObservableObject {
    @Published var path: [RouteView] = []

    func push(_ routeView: RouteView) {
        path.append(routeView)
    }

    func pop(_ routeView: RouteView) {
        path.removeLast()
    }

    func popToRoot() {
        path = []
    }
}

class RouteDirection: ObservableObject {
    @Published var routeFieldStatus: RouteFieldStatus = .from
}
