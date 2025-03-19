    //
    //  FromToViewModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import Foundation

final class ContentViewViewModel: ObservableObject {
    @Published var routeField: FromToModel

    init() {
        self.routeField = FromToModel(fromField: "", toField: "")
    }
}
