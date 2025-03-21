    //
    //  StoryModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 27.02.2025.
    //

import SwiftUI

struct PreviewImage: Hashable {
    let previewImageName: String
}

struct SingleStoryModel: Hashable {
    let previewImageTitle: ImageResource
    let imageTitle: [ImageResource]
    var didSee: Bool
    let titleText: String?
    let description: String?
}

struct StoryModel: Hashable {
    let stories: [SingleStoryModel]
}
