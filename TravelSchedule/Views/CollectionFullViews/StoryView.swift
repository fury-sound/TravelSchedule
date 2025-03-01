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
//    @Binding var selectedTab: Int
//    @Binding var currentStory: SingleStoryModel
//    @Binding var imageBig: Image  //= Image("big1")
//    @Binding var stories: [SingleStoryModel]

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

//#Preview {
//    @State var showFullImage: Bool = true
//    @State var selectedTab: Int = 0
//    var currentStory: SingleStoryModel = SingleStoryModel(previewImageTitle: "Preview1", imageTitle: ["big1", "big2"], didSee: false, titleText: titleText, description: descriptionText)
//    let imageName = currentStory.imageTitle[selectedTab]
//    StoryView(showFullImage: $showFullImage, currentStory: currentStory, selectedTab: $selectedTab)
//}

//#Preview {
//    @State var showFullImage: Bool = true
//    @State var selectedTab: Int = 0
//    var currentStory: SingleStoryModel = SingleStoryModel(previewImageTitle: "Preview1", imageTitle: ["big1", "big2"], didSee: false, titleText: titleText, description: descriptionText)
//    let imageName = currentStory.imageTitle[selectedTab]
//    StoryView(showFullImage: $showFullImage, currentStory: currentStory, selectedTab: $selectedTab)
//}
//
//#Preview {
//    @State var showFullImage: Bool = false
//    @State var selectedTab: Int = 0
//    var currentStory: SingleStoryModel = SingleStoryModel(previewImageTitle: "Preview1", imageTitle: ["big1", "big2"], didSee: false, titleText: titleText, description: descriptionText)
//    let imageName = currentStory.imageTitle[selectedTab]
//    StoryView(showFullImage: $showFullImage, currentStory: currentStory, selectedTab: $selectedTab)
//}
