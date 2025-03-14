    //
    //  FromToViewModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import Foundation

final class ContentViewViewModel: ObservableObject {
        //    @StateObject var FromToViewModel: FromToViewModel
    @Published var routeField: FromToModel
//    @Published var selectedCity: String = ""
//    @Published var selectedStation: String = ""
//    @Published var toField: FromToModel
//
    init() {
        self.routeField = FromToModel(fromField: "", toField: "")
    }
}
