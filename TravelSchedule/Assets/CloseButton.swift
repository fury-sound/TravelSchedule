//
//  CloseButton.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 27.02.2025.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    let image: String = "ypClose"

    var body: some View {
        Button(action: action) {
            Label("Close", image: image )
                .labelStyle(.iconOnly)
        }
    }
}

//#Preview {
//    CloseButton()
//}
