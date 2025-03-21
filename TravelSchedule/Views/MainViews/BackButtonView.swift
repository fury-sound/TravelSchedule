//
//  BackButtonView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 21.03.2025.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
//        Button(action: {
//            presentationMode.wrappedValue.dismiss()
//        })
//        {
//            Image(systemName: "chevron.left")
//                .foregroundColor(.ypBlack)
//        }
//    }
    Button {
            presentationMode.wrappedValue.dismiss()
    } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.ypBlack)
        }
    }
}

#Preview {
    BackButtonView()
}
