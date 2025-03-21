    //
    //  ContentViewViewModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import SwiftUI
import Combine

struct StoryConfiguration {
    let timerTickInternal: TimeInterval
    let progressPerTick: CGFloat

    init(
        storiesCount: Int,
        secondsPerStory: TimeInterval = 5,
        timerTickInternal: TimeInterval = 0.25
    ) {
        self.timerTickInternal = timerTickInternal
        self.progressPerTick = 1.0 / CGFloat(storiesCount) / secondsPerStory * timerTickInternal
    }
}

final class ContentViewViewModel: ObservableObject {
    @Published var whereField: Int = 0
    @Published var showFullImage: Bool = false
    @Published var selectedStorySetIndex: Int = 0
    @Published var selectedTab: Int = 0
    @Published var storiesCount: Int = 2
    @Published var currentStory = SingleStoryModel(previewImageTitle: .preview1, imageTitle: [.big1, .big2], didSee: false, titleText: titleText, description: descriptionText)
    @Published var viewModel = StoryViewViewModel()
    @Published var configuration: StoryConfiguration
    @Published var timer: Timer.TimerPublisher = Timer.TimerPublisher(interval: 5, runLoop: .main, mode: .common)

    init() {
        self.configuration = StoryConfiguration(storiesCount: 2, secondsPerStory: 5, timerTickInternal: 0.25)
    }

    func setupConfiguration(storiesCount: Int) {
        self.configuration = StoryConfiguration(storiesCount: storiesCount)
        self.timer = ContentViewViewModel.createTimer(configuration: configuration)
    }

    static func createTimer(configuration: StoryConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

