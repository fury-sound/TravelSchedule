//
//  ServerErrorView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 16.02.2025.
//

import SwiftUI

struct ServerErrorView: View {
    var body: some View {
        Image("ypServerError")
        Text("Ошибка сервера")
            .font(.system(size: 24, weight: .bold))
    }
}

#Preview {
    ServerErrorView()
}
