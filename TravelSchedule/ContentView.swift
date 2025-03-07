//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 23.01.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

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

struct ContentView: View {
    let travelServices = TravelServices()
    @ObservedObject var routeSettingViewModel = RouteSettingViewModel()
    @State private var fromField: String = "Откуда"
    @State private var toField: String = "Куда"
    @State private var whereField: Int = 0
    @State private var showFullImage: Bool = false
    @State private var selectedStorySetIndex: Int = 0
    @State private var selectedTab: Int = 0
    @State private var currentStory = SingleStoryModel(previewImageTitle: .preview1, imageTitle: [.big1, .big2], didSee: false, titleText: titleText, description: descriptionText)
    @State private var viewModel = StoryViewViewModel()
    @State var configuration: StoryConfiguration = StoryConfiguration(storiesCount: 2, secondsPerStory: 5, timerTickInternal: 0.25)
    @State var timer: Timer.TimerPublisher = Timer.TimerPublisher(interval: 5, runLoop: .main, mode: .common)
    @StateObject var navModel = NavigationModel()
    //    @Environment(CityList.self) var cityList

    static func createTimer(configuration: StoryConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }

    var body: some View {

        NavigationStack(path: $navModel.path) {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        StoryCollectionView(viewModel: $viewModel, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
                    }
                    .frame(height: 140)
                    .padding(.init(top: 24, leading: 0, bottom: 20, trailing: 0))
                    FromToView(path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
                        .navigationDestination(for: RouteView.self) { routeView in
                            switch routeView {
                                case .locationView:
                                    LocationSelection(headerText: "Выбор города", path: $navModel.path)
                                case .stationView(let city):
                                    StationSelection(header: (city, 0), path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
                            }
                        }

                    if fromField != "Откуда" && toField != "Куда" {
//                        NavigationLink(destination: CarrierSearch(fromField: $fromField, toField: $toField, filterConnectionState: $routeSettingViewModel.filterConnectionState)) {
                        NavigationLink(destination: CarrierSearch(fromField: $fromField, toField: $toField)) {
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
                    }
                    Spacer()
//                    Divider()
//                        .padding(.bottom, 10)
//                        .opacity(showFullImage ? 0 : 1)
                }
                .background(Color.ypWhite)
                ZStack {
                    if showFullImage {
                        StoryTabView(viewModel: $viewModel, currentStory: $viewModel.storiesCollection[selectedStorySetIndex], showFullImage: $showFullImage, selectedTab: $selectedTab, selectedStorySetIndex: $selectedStorySetIndex, timer: $timer, configuration: $configuration)
                            .transition(.asymmetric(insertion: .move(edge: .top), removal: .scale(scale: 0.01)))
                            .animation(.easeIn(duration: 1), value: showFullImage)

                        if #available(iOS 18.0, *) {
                            Text("")
                                .hidden()
                                .toolbarVisibility(showFullImage ? .hidden : .visible, for: .tabBar) // for iOS 18.0
                        } else {
                            Text("")
                                .hidden()
                                .toolbar(showFullImage ? .hidden : .visible, for: .tabBar) // deprecated
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)

        .onAppear() {
            configuration = StoryConfiguration(storiesCount: viewModel.storiesCollection[selectedStorySetIndex].imageTitle.count)
            timer = ContentView.createTimer(configuration: configuration)
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
            }
        }
    }
}

#Preview {
    ContentView()
}


/*

 //                            .transition(.opacity)
 //                            .zIndex(0)

 //                            .opacity(showTabBar ? 1 : 0)
 //                            .scaleEffect(1)
 //                            .animation(.easeIn, value: 0.5)
 //                        .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
 //                        .transition(.slide)
 //                        .zIndex(0)

 //                .transition(.move(edge: .top))
 //                .opacity(showFullImage ? 1 : 0)

 //                .rotationEffect(.degrees(30))
 //                .slide(showFullImage ? 1 : 0)


 //        VStack(spacing: 16) {

 //            HStack(alignment: .top) {
 //            }.ignoresSafeArea(.all)
 //            .ignoresSafeArea()
 //            .frame(maxHeight: .infinity)
 //            LazyHStack(alignment: .top, spacing: 5) {
 //            LazyHStack {
 //                .ypBlueUniversal
 //                Rectangle()
 ////                    .frame(width: 92, height: 140)
 //                Rectangle()
 ////                    .frame(width: 92, height: 140)
 //            }.frame(maxHeight: 100)
 //                .background(Color.gray)
 //            Spacer(minLength: 44)
 //            FromToView()
 //            Spacer()

 //                .padding()
 //        }.frame(maxHeight: .infinity, alignment: .top)

 //                FromToView(path: $navModel.path, fromField: $fromField, toField: $toField)
 //                    .navigationDestination(for: RouteFieldStatus.self) { routeStatus in
 //                        switch routeStatus {
 //                            case .from:
 //                                if $navModel.path.isEmpty {
 //                                    LocationSelection(headerText: "Выбор города", path: $navModel.path)
 //                                } else {
 //                                    StationSelection(header: city, path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
 //                                }
 //                            case .to:
 //                        }
 //                    }
 */
