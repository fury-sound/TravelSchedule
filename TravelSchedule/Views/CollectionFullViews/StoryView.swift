    //
    //  StoryView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 27.02.2025.
    //

import SwiftUI

struct StoryView: View {
    var currentImage: String = "big1"
    @Binding var showFullImage: Bool
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryImageViewFull(currentImage: currentImage, showFullImage: $showFullImage)
        }
    }
}

#Preview {
    var currentImage = "big1"
    @State var showFullImage: Bool = true
    @State var selectedTab: Int = 0
    StoryView(currentImage: currentImage, showFullImage: $showFullImage)
}

