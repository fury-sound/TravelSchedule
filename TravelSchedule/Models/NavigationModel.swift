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
//    @Published var path = NavigationPath()
    @Published var path: [RouteView] = []
//    @Published var fromField: String = ""
//    @Published var toField: String = ""

    func push(_ routeView: RouteView) {
        path.append(routeView)
    }

    func pop(_ routeView: RouteView) {
        path.removeLast()
    }

    func popToRoot() {
        path = []
//        path = NavigationPath()
    }
}

//@Observable class RouteDirection {
//    var routeFieldStatus: RouteFieldStatus = .from
//}

class RouteDirection: ObservableObject {
    @Published var routeFieldStatus: RouteFieldStatus = .from
}
