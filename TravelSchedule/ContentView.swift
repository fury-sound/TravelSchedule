//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 23.01.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

struct ContentView: View {
    @StateObject var contentViewViewModel = ContentViewViewModel()
    @ObservedObject var travelServices = TravelServices()
    @EnvironmentObject var travelViewModel: TravelViewModel
    @StateObject private var viewModel = StoryViewViewModel()
    @StateObject var navModel = NavigationModel()

    //    @State private var whereField: Int
//    @State private var showFullImage: Bool = false
//    @State private var selectedStorySetIndex: Int = 0
//    @State private var selectedTab: Int = 0
//    @State private var currentStory = SingleStoryModel(previewImageTitle: .preview1, imageTitle: [.big1, .big2], didSee: false, titleText: titleText, description: descriptionText)
//    @State var configuration: StoryConfiguration = StoryConfiguration(storiesCount: 2, secondsPerStory: 5, timerTickInternal: 0.25)
//    @State var timer: Timer.TimerPublisher = Timer.TimerPublisher(interval: 5, runLoop: .main, mode: .common)

//    static func createTimer(configuration: StoryConfiguration) -> Timer.TimerPublisher {
//        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
//    }

    var body: some View {

        NavigationStack(path: $navModel.path) {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        StoryCollectionView(viewModel: $contentViewViewModel.viewModel, showFullImage: $contentViewViewModel.showFullImage, selectedStorySetIndex: $contentViewViewModel.selectedStorySetIndex, selectedTab: $contentViewViewModel.selectedTab)
//                        StoryCollectionView(viewModel: $viewModel, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
                    }
                    .frame(height: 140)
                    .padding(.init(top: 24, leading: 0, bottom: 20, trailing: 0))
                    FromToView(path: $navModel.path, whereField: $contentViewViewModel.whereField, travelViewModel: travelViewModel)
                        .navigationDestination(for: RouteView.self) { routeView in
                            switch routeView {
                                case .locationView:
                                    LocationSelection(headerText: "Выбор города", path: $navModel.path, travelViewModel: travelViewModel)
                                case .stationView(let city):
                                    StationSelection(header: (city, 0), path: $navModel.path, whereField: $contentViewViewModel.whereField, travelViewModel: travelViewModel)
                            }
                        }

                    if travelViewModel.fromField.0 != "Откуда" && travelViewModel.toField.0 != "Куда" {
                            NavigationLink(destination:
                                            CarrierSearch()
                                .environmentObject(travelViewModel)
                            ) {
                                Text("Найти")
                                    .font(.system(size: 17, weight: .bold))
                                    .padding()
                                    .frame(width: 150, height: 60)
                                    .background(.ypBlueUniversal)
                                    .foregroundStyle(Color.ypWhiteUniversal)
                                    .clipShape(.rect(cornerRadius: 16))
                            }
                            .background(Color.clear)
                            .padding([.top, .bottom], 16)
                            .padding([.leading, .trailing], 8)
                            .simultaneousGesture(TapGesture().onEnded { _ in
                                Task {
                                    try await travelViewModel.getRouteData(travelViewModel.fromField.2, travelViewModel.toField.2)
                                }
                            })
                    }
                    Spacer()
                }
                .background(Color.ypWhite)
                ZStack {
                    if contentViewViewModel.showFullImage {
//                        StoryTabView(viewModel: $viewModel, currentStory: $viewModel.storiesCollection[selectedStorySetIndex], showFullImage: $showFullImage, selectedTab: $selectedTab, selectedStorySetIndex: $selectedStorySetIndex, timer: $timer, configuration: $configuration)
                        StoryTabView(viewModel: $contentViewViewModel.viewModel, currentStory: $viewModel.storiesCollection[contentViewViewModel.selectedStorySetIndex], showFullImage: $contentViewViewModel.showFullImage, selectedTab: $contentViewViewModel.selectedTab, selectedStorySetIndex: $contentViewViewModel.selectedStorySetIndex, timer: $contentViewViewModel.timer, configuration: $contentViewViewModel.configuration)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .scale(scale: 0.01)))
                            .animation(.easeIn(duration: 1), value: contentViewViewModel.showFullImage)

                        if #available(iOS 18.0, *) {
                            Text("")
                                .hidden()
                                .toolbarVisibility(contentViewViewModel.showFullImage ? .hidden : .visible, for: .tabBar) // for iOS 18.0
                        } else {
                            Text("")
                                .hidden()
                                .toolbar(contentViewViewModel.showFullImage ? .hidden : .visible, for: .tabBar) // deprecated
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)

        .onAppear() {
//            configuration = StoryConfiguration(storiesCount: viewModel.storiesCollection[contentViewViewModel.selectedStorySetIndex].imageTitle.count)
//            configuration = StoryConfiguration(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count)
//            timer = ContentView.createTimer(configuration: configuration)
            contentViewViewModel.setupConfiguration(storiesCount: contentViewViewModel.storiesCount)
            Task {
                // раскомментировать для запуска соответствующих сервисов
                //                try betweenStations()
                //                try stationSchedule()
                //                try nearestStations()
                //                try nearestSettlement()
                //                try carriers()
                //                try travelServices.showCopyrightInfo()
                //                try showCopyrightInfo()
                //                try showStationsOnRoute()
                //                try showAllStations()
                await travelViewModel.getTravelData()
            }
        }
    }
}

#Preview {
    ContentView()
}
