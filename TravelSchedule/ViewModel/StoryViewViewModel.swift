//
//  StoryViewViewModel.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 11.02.2025.
//

import SwiftUI

final class StoryViewViewModel: ObservableObject {

    var previewImages: [String] = []
    let previewImage1Model = PreviewImage(previewImageName: "Preview1")
    let previewImage2Model = PreviewImage(previewImageName: "Preview2")
    let previewImage3Model = PreviewImage(previewImageName: "Preview3")
    let previewImage4Model = PreviewImage(previewImageName: "Preview4")
    let previewImage5Model = PreviewImage(previewImageName: "Preview5")
    let previewImage6Model = PreviewImage(previewImageName: "Preview6")
    let previewImage7Model = PreviewImage(previewImageName: "Preview7")
    let previewImage8Model = PreviewImage(previewImageName: "Preview8")
    let previewImage9Model = PreviewImage(previewImageName: "Preview9")

//    let previewImage2 = PreviewImage(previewImageName: "Preview2")
//    let previewImage3 = PreviewImage(previewImageName: "Preview3")
//    let previewImage4 = PreviewImage(previewImageName: "Preview4")
//    let previewImage5 = PreviewImage(previewImageName: "Preview5")
//    let previewImage6 = PreviewImage(previewImageName: "Preview6")
//    let previewImage7 = PreviewImage(previewImageName: "Preview7")
//    let previewImage8 = PreviewImage(previewImageName: "Preview8")
//    let previewImage9 = PreviewImage(previewImageName: "Preview9")

    init() {
        let previewImage1 = previewImage1Model.previewImageName
        let previewImage2 = previewImage2Model.previewImageName
        let previewImage3 = previewImage3Model.previewImageName
        let previewImage4 = previewImage4Model.previewImageName
        let previewImage5 = previewImage5Model.previewImageName
        let previewImage6 = previewImage6Model.previewImageName
        let previewImage7 = previewImage7Model.previewImageName
        let previewImage8 = previewImage8Model.previewImageName
        let previewImage9 = previewImage9Model.previewImageName

        self.previewImages = [
            previewImage1,
            previewImage2,
            previewImage3,
            previewImage4,
            previewImage5,
            previewImage6,
            previewImage7,
            previewImage8,
            previewImage9
        ]
    }
}


