//
//  StoryPreviewImage.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 11.02.2025.
//

import SwiftUI

struct StoryPreviewImage: View {
    var previewImage: ImageResource
    @Binding var didSee: Bool
    @Binding var showFullImage: Bool
    @Binding var selectedStorySetIndex: Int
    @Binding var selectedTab: Int

    var body: some View {

        ZStack(alignment: .bottomTrailing) {
            Image(previewImage)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .opacity(didSee ? 0.5 : 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(didSee ? Color.clear : .ypBlueUniversal, lineWidth: 4)
                )

            Text("Text Text Text Text Text Text T...")
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12))
                .padding(.bottom, 12)
                .padding(.horizontal, 8)
                .lineLimit(3)
        }
        .frame(width: 92, height: 140)
    }
}

#Preview("show full false") {
    @State var showFullImage: Bool = false
    @State var selectedStorySetIndex: Int = 0
    @State var selectedTab = 0
    @State var didSee: Bool = false
    StoryPreviewImage(previewImage: .preview2, didSee: $didSee, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
}

#Preview("show full true") {
    @State var showFullImage: Bool = false
    @State var selectedStorySetIndex: Int = 0
    @State var selectedTab = 0
    @State var didSee: Bool = true
    StoryPreviewImage(previewImage: .preview1, didSee: $didSee, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
}
