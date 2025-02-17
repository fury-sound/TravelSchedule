    //
    //  StoryImage.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 11.02.2025.
    //

import SwiftUI

struct StoryImage: View {
    var previewImage: Image

    var body: some View {
        ZStack(alignment: .bottom) {
            previewImage
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.ypBlueUniversal, lineWidth: 4)
//                        .stroke(Color.clear, lineWidth: 0)
                )
            Text("Text Text Text Text Text Text T...")
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12))
                .padding(.bottom, 12)
                .padding(.horizontal, 8)
                .lineLimit(3)
        }.frame(width: 92, height: 140)
    }
}

#Preview {
    StoryImage(previewImage: Image("Preview1"))
}
