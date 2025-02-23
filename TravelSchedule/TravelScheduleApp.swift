//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 23.01.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
//    @State var routeDirection = RouteDirection()
    @StateObject var routeDirection = RouteDirection()

    var body: some Scene {
        WindowGroup {
            SplashScreen()
//                .environment(routeDirection)
                .environmentObject(routeDirection)
//            ContentView()
        }
    }
}
