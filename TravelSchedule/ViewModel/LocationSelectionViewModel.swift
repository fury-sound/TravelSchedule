//
//  LocationSelectionViewModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 21.03.2025.
//

import SwiftUI

final class LocationSelectionViewModel: ObservableObject {
    @Published var searchString: String = ""
    @Published var noInternetError: Bool = false
    @Published var serverError: Bool = false
}
