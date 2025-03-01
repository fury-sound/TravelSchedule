//
//  StoryTabView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 27.02.2025.
//

import SwiftUI
import Combine



struct StoryTabView: View {
    @Binding var viewModel: StoryViewViewModel
    @Binding var currentStory: SingleStoryModel
    @Binding var showFullImage: Bool
    @Binding var selectedTab: Int
    @Binding var selectedStorySetIndex: Int
//    @State var storedProgress: CGFloat = 0
    @State private var isDragging: Bool = false
    @State private var progress: CGFloat = 0
    @Binding var timer: Timer.TimerPublisher
    @Binding var configuration: StoryConfiguration
    @State private var cancellable: Cancellable?
    @State private var offset: CGFloat = 0
    @State private var offsetY: CGFloat = 0
    @State private var currentIndex: Int = 0
    private let screenWidth = UIScreen.main.bounds.width
//    private var timerConfiguration: TimerConfiguration { .init(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count) }
//    @State var currentProgress: CGFloat = 0 {
//        didSet {
//            storedProgress = currentProgress
//            didChangeCurrentProgress(newProgress: currentProgress)
//        }
//    }
//    @State var storedProgress: CGFloat = 0

    private func previousStorySet() {
//        selectedStorySetIndex > 0 ? (selectedStorySetIndex -= 1) : (showFullImage = false)
        if selectedStorySetIndex > 0 {
            selectedStorySetIndex -= 1
            viewModel.storiesCollection[selectedStorySetIndex].didSee = true
        } else {
            showFullImage = false
        }
    }

    private func nextStorySet() {
//        selectedStorySetIndex < viewModel.storiesCollection.count - 1 ? (selectedStorySetIndex += 1) : (showFullImage = false)
        if selectedStorySetIndex < viewModel.storiesCollection.count - 1 {
            selectedStorySetIndex += 1
            viewModel.storiesCollection[selectedStorySetIndex].didSee = true
        } else {
            showFullImage = false
        }
    }

    private func timerTick() {
//        selectedStorySetIndex = Int(progress * CGFloat(viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count))
        let storiesCount = viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        withAnimation {
        if currentStoryIndex >= currentIndex {
            currentIndex = currentStoryIndex
        }
        var nextProgress = progress + configuration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
            currentIndex = 0
//            resetTimer()
        }
//        withAnimation {
            progress = nextProgress
        }
    }

    private func nextStory() {
        let storiesCount = viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count
        let currentStoryIndex = Int(progress * CGFloat(storiesCount))
        let nextStoryIndex = currentStoryIndex + 1 < storiesCount ? currentStoryIndex + 1 : 0
        withAnimation {
            progress = CGFloat(nextStoryIndex) / CGFloat(storiesCount)
        }
    }

    private func resetTimer() {
        cancellable?.cancel()
        timer = ContentView.createTimer(configuration: configuration)
        cancellable = timer.connect()
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            ForEach(
                viewModel.storiesCollection[selectedStorySetIndex].imageTitle.indices,
                id: \.self
            ) { index in
                StoryView(
                    currentImage: currentStory.imageTitle[index],
                    showFullImage: $showFullImage
                )
                .offset(x: CGFloat(index - currentIndex) * screenWidth)
            }
            ProgressBar(numberOfSections: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))

//            StoriesProgressBar(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count, timerConfiguration: timerConfiguration, currentProgress: $currentProgress)
//                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
//                .onChange(of: currentProgress) { _, newValue in
//                    didChangeCurrentProgress(newProgress: newValue)
//                }

            CloseButton(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showFullImage = false
                }
                print("Close Story")
            })
            .padding(.top, 60)
            .padding(.trailing, 15)
        }
//        .ignoresSafeArea()
        .onAppear {
            configuration = StoryConfiguration(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count)
            timer = ContentView.createTimer(configuration: configuration)
            cancellable = timer.connect()
//            selectedStorySetIndex = Int(progress * CGFloat(viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count))
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) { _ in
            timerTick()

        }
        .onTapGesture { value in
            offset = value.x
            withAnimation(.bouncy()) {
//            withAnimation {
                if offset < 100 {
                    if currentIndex > 0 {
                        currentIndex -= 1
                        nextStory()
                    } else if currentIndex == 0 {
//                        print("in prev")
//                        currentIndex = 0
//                        progress = 0
                        previousStorySet()
                    }
                    resetTimer()
                    offset = 0
                }
                if offset > screenWidth - 100 {
                    if currentIndex < currentStory.imageTitle.count - 1 {
                        currentIndex += 1
                        nextStory()
                    } else if currentIndex == currentStory.imageTitle.count - 1 {
//                        print("in next")
                        currentIndex = 0
                        progress = 0
                        nextStorySet()
                    }
                    resetTimer()
                    offset = 0
                }
            }
        }
//        .offset(y: offsetY)
        .gesture(
            DragGesture()
                .onChanged { value in
                    offset = value.translation.width
                    offsetY = value.translation.height
//                    isDragging = true
                }
                .onEnded { value in
//                    withAnimation(.bouncy()) {
//                    withAnimation {
                        if value.translation.width > 100 {
                            withAnimation(.bouncy()) {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                } else if currentIndex == 0 {
                                    currentIndex = 0
                                    previousStorySet()
                                }
                            }
                            nextStory()
                            resetTimer()
                            offset = 0
                        } else if value.translation.width < -100 {
                            withAnimation(.bouncy()) {
                                if currentIndex < currentStory.imageTitle.count - 1 {
                                    currentIndex += 1
                                } else if currentIndex == currentStory.imageTitle.count - 1 {
                                    currentIndex = 0
                                    nextStorySet()
                                }
                            }
                            nextStory()
                            resetTimer()
                            offset = 0
                        } else if value.translation.height > 200 {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                showFullImage = false
                                offsetY = 0
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                offset = 0
                                offsetY = 0
                            }
                        }
//                    isDragging = false
//                    }
                }

        )
//        .scaleEffect(offsetY > 100 ? 0.95 : 1)
//        .scaleEffect(isDragging ? 0.95 : 1)

//        .opacity(isDragging ? 0.5 : 1)
        //                }
        //                .ignoresSafeArea()
        //            .transition(.move(edge: .top))
        //            .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))


        //            .transition(.scale(scale: 0.5))
        //            .gesture(DragGesture())

        //            }

        //        .offset(y: showFullImage ? 0 : UIScreen.main.bounds.height)
        //        .animation(.easeInOut(duration: 0.5), value: showFullImage)
        //        .transition(.asymmetric(
        //            insertion: AnyTransition
        //                .scale(scale: 0.1, anchor: .center)
        //                .combined(with: .opacity),
        //            removal: .move(edge: .trailing))
        //        )

        //        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

#Preview {
    @State var viewModel = StoryViewViewModel()
    @State var showFullImage: Bool = true
    @State var selectedTab: Int = 1
    @State var selectedStorySetIndex: Int = 1
    @State var currentStory = viewModel.storiesCollection[selectedTab]
    @State var configuration = StoryConfiguration(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count)
    @State var timer = ContentView.createTimer(configuration: configuration)
    //        @State var currentStory = SingleStoryModel(previewImageTitle: "Preview1", imageTitle: ["big1", "big2"], didSee: false, titleText: titleText, description: descriptionText)
//    StoryTabView(currentStory: $currentStory, showFullImage: $showFullImage, selectedTab: $selectedTab, selectedStorySetIndex: $selectedStorySetIndex)
    StoryTabView(viewModel: $viewModel, currentStory: $currentStory, showFullImage: $showFullImage, selectedTab: $selectedTab, selectedStorySetIndex: $selectedStorySetIndex, timer: $timer, configuration: $configuration)
}

//#Preview {
//        @State var showFullImage: Bool = true
//        @State var selectedTab: Int = 0
//        StoryTabView(selectedTab: $selectedTab, showFullImage: $showFullImage)
//}
