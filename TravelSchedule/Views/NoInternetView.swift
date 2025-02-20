//
//  NoInternetView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 16.02.2025.
//

import SwiftUI

struct NoInternetView: View {
    var body: some View {
        Image("ypNoInternet")
        Text("Нет интернета")
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    NoInternetView()
}
