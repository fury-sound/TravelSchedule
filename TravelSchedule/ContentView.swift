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
    @ObservedObject var travelServices = TravelServices()
    @EnvironmentObject var travelViewModel: TravelViewModel
//    @StateObject var travelViewModel: TravelViewModel
//    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
    //    @State private var fromField: String = "Откуда"
    //    @State private var toField: String = "Куда"
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

//    init() {
//        routeSettingViewModel = RouteSettingViewModel(travelViewModel: travelViewModel)
//    }

    var body: some View {

        NavigationStack(path: $navModel.path) {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        StoryCollectionView(viewModel: $viewModel, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
                    }
                    .frame(height: 140)
                    .padding(.init(top: 24, leading: 0, bottom: 20, trailing: 0))
                    //                    FromToView(path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField)
                    FromToView(path: $navModel.path, whereField: $whereField, travelViewModel: travelViewModel)
                        .navigationDestination(for: RouteView.self) { routeView in
                            switch routeView {
                                case .locationView:
                                    LocationSelection(headerText: "Выбор города", path: $navModel.path, travelViewModel: travelViewModel)
                                case .stationView(let city):
                                    StationSelection(header: (city, 0), path: $navModel.path, whereField: $whereField, travelViewModel: travelViewModel)
                                    //                                    StationSelection(header: (city, 0), path: $navModel.path, whereField: $whereField, fromField: $fromField, toField: $toField, travelViewModel: travelViewModel)
                            }
                        }

                    if travelViewModel.fromField.0 != "Откуда" && travelViewModel.toField.0 != "Куда" {
                        //                        NavigationLink(destination: CarrierSearch(fromField: $fromField, toField: $toField, filterConnectionState: $routeSettingViewModel.filterConnectionState)) {
                        //                        NavigationLink(destination: CarrierSearch(fromField: $fromField, toField: $toField)) {
                        //                        NavigationLink(destination: CarrierSearch(fromField: travelViewModel.fromField, toField: travelViewModel.toField)) {
                        NavigationLink(destination:
                                        CarrierSearch(travelViewModel: travelViewModel)
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
                    }
                    Spacer()
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

                await travelViewModel.getTravelData()
                //                try travelServices.betweenStations("s9602494", "s9623135")
                //                print("travelServices.travelDataAll.count in onAppear:", travelServices.travelDataAll.count)

                //                try await travelViewModel.getTravelData()
            }
        }
    }
}

#Preview {
//    var travelViewModel = TravelViewModel()
//    ContentView(travelViewModel: travelViewModel)
    ContentView()
}
