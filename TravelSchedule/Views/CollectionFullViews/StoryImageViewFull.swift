    //
    //  StoryImageViewFull.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 26.02.2025.
    //

import SwiftUI

struct StoryImageViewFull: View {
    var currentImage: String = "big1"
    @Binding var showFullImage: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
                Image(currentImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack {
                Text(titleText)
                    .font(.bold34)
                    .foregroundStyle(Color.white)
                    .lineLimit(2)
                    .padding(.bottom, 16)
                Text(descriptionText)
                    .font(.regular20)
                    .foregroundStyle(Color.white)
                    .lineLimit(3)
                    .padding(.bottom, 40)
            }
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.ypBlack.opacity(showFullImage ? 1 : 0))
    }
}

#Preview {
    @State var showFullImage: Bool = true
    StoryImageViewFull(currentImage: "big1", showFullImage: $showFullImage)
}

#Preview {
    @State var showFullImage: Bool = false
    StoryImageViewFull(currentImage: "big1", showFullImage: $showFullImage)
}
