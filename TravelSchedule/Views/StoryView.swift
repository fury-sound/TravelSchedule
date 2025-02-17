    //
    //  StoryView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 10.02.2025.
    //

import SwiftUI

struct StoryView: View {

    @StateObject private var viewModel = StoryViewViewModel()

    var body: some View {
        LazyHStack {
            ForEach(viewModel.previewImages, id: \.self) { imageName in
                StoryImage(previewImage: Image(imageName))
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    StoryView()
}
