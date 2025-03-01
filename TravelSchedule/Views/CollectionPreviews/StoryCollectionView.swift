    //
    //  StoryCollectionView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 10.02.2025.
    //

import SwiftUI

struct StoryCollectionView: View {

    @Binding var viewModel: StoryViewViewModel
    @Binding var showFullImage: Bool
    @Binding var selectedStorySetIndex: Int
    @Binding var selectedTab: Int

    private func handleTap(on index: Int) {
        selectedStorySetIndex = index
        viewModel.storiesCollection[index].didSee = true
    }

    var body: some View {
        LazyHStack {
            ForEach(viewModel.storiesCollection.indices, id: \.self) { index in
                StoryPreviewImage(previewImage: viewModel.storiesCollection[index].previewImageTitle, didSee: $viewModel.storiesCollection[index].didSee, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
                    .onTapGesture {
                        handleTap(on: index)
                            withAnimation(.easeInOut(duration: 2)) {
                            showFullImage = true
                        }
                    }
            }
            .padding(.horizontal, 6)
        }
    }
}

#Preview {
    @State var viewModel = StoryViewViewModel()
    @State var selectedStorySetIndex = 0
    @State var selectedTab = 0
    StoryCollectionView(viewModel: $viewModel, showFullImage: .constant(false), selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
}


