    //
    //  RouteSettings.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

struct RouteSettings: View {
    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
    @ObservedObject var travelViewModel: TravelViewModel
//    @State private var isMorning = false
//    @State private var isDay = false
//    @State private var isEvening = false
//    @State private var isNight = false
    @State private var yesNo = ["Да", "Нет"]
    @State private var periods = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]
//    @State private var withConnection: String = ""
    @Binding var isActive: Bool

    var body: some View {

        VStack {
            VStack(alignment: .leading) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                    .padding([.top, .bottom], 16)
                VStack {
//                    Toggle(isOn: $isMorning) {
                        Toggle(isOn: $routeSettingViewModel.isMorning) {
                        Text(periods[0])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding([.top, .bottom], 19)
//                    Toggle(isOn: $isDay) {
                        Toggle(isOn: $routeSettingViewModel.isDay) {
                        Text(periods[1])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding([.top, .bottom], 19)
//                    Toggle(isOn: $isEvening) {
                        Toggle(isOn: $routeSettingViewModel.isEvening) {
                        Text(periods[2])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding([.top, .bottom], 19)
//                    Toggle(isOn: $isNight) {
                        Toggle(isOn: $routeSettingViewModel.isNight) {
                        Text(periods[3])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .toggleStyle(CheckboxToggleStyle())
                    .padding([.top, .bottom], 19)
                }
                Text("Показывать варианты с пересадками")
                    .lineLimit(2)
                    .font(.system(size: 24, weight: .bold))
                    .padding([.top, .bottom], 16)
                VStack {
                    Toggle(isOn: $routeSettingViewModel.isYes) {
                        Text(yesNo[0])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .tag(0)
                    .toggleStyle(RadioButtonStyle(travelViewModel: travelViewModel, routeSettingViewModel: routeSettingViewModel, tag: 0))
                    .padding([.top, .bottom], 19)
                    Toggle(isOn: $routeSettingViewModel.isNo) {
                        Text(yesNo[1])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .tag(1)
                    .toggleStyle(RadioButtonStyle(travelViewModel: travelViewModel, routeSettingViewModel: routeSettingViewModel, tag: 1))
                    .padding([.top, .bottom], 19)
                }
            }
            .navigationBarBackButtonHidden(true)
            .padding(16)
//            .onAppear {
//                switch viewModel.filterConnectionState {
//                    case .allConnections:
//                        viewModel.isYes = true
//                    case .noConnections:
//                        viewModel.isNo = true
//                    default:
//                        viewModel.isYes = false
//                        viewModel.isNo = false
//                }
//            }
            Spacer()
            if routeSettingViewModel.isYes || routeSettingViewModel.isNo {
                VStack {
//                    ApplyButtonView()
                    ApplyButtonView(routeSettingViewModel: routeSettingViewModel)
                }
            }
        }
        .background(Color.ypWhite)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
    }
}

struct ApplyButtonView: View {
    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {

        VStack {
            Text("Применить")
                .font(.system(size: 17, weight: .bold))
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(.ypBlueUniversal)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 16))
        }
        .padding([.top, .bottom], 10)
        .padding([.leading, .trailing], 16)
        .onTapGesture {
//            print(routeSettingViewModel.isYes, routeSettingViewModel.isNo)
            routeSettingViewModel.filterRoute()
            dismiss()
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack{
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

struct RadioButtonStyle: ToggleStyle {
    @ObservedObject var travelViewModel: TravelViewModel
    @ObservedObject var routeSettingViewModel: RouteSettingViewModel
    @State var tag: Int?

    func makeBody(configuration: Self.Configuration) -> some View {
        HStack{
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "largecircle.fill.circle" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    switch tag {
                        case 0:
                            if !routeSettingViewModel.isYes {
                                routeSettingViewModel.isYes = true
                                routeSettingViewModel.isNo = false
                            }
                        case 1:
                            if !routeSettingViewModel.isNo {
                                routeSettingViewModel.isNo = true
                                routeSettingViewModel.isYes = false
                            }
                        default:
                            break
                    }
                }
        }
    }
}

#Preview("Параметры маршрута") {
    @State var filterConnection: Bool? //= false
    @State var isActive: Bool = true
    var travelViewModel = TravelViewModel()
//    @State var routeSettingViewModel = RouteSettingViewModel() // = true
    @State var routeSettingViewModel = RouteSettingViewModel() // = true
//    @State var routeSettingViewModel = RouteSettingViewModel(initialArray: travelViewModel.selectedRouteArray) // = true
    RouteSettings(routeSettingViewModel: routeSettingViewModel, travelViewModel: travelViewModel, isActive: $isActive)
}

#Preview("Forms and Sections") {
    RouteSettingsWithForm()
}

//MARK: тестирование использования формы и ее секций, 2-й превью
struct RouteSettingsWithForm: View {
    @State private var isMorning = false
    @State private var isDay = false
    @State private var isEvening = false
    @State private var isNight = false
    @State private var isYes = false
    @State private var isNo = false
        //    @State private var tag: Int = 0
    @State private var yesNo = ["Да", "Нет"]
    @State private var periods = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]
//    @State private var withConnection: String = ""

    var body: some View {
        Form {
            Section(header: Text("Время отправления")) {
                VStack {
                    Toggle(isOn: $isMorning) {
                        Text(periods[0])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .padding(.bottom, 16)
                    Toggle(isOn: $isDay) {
                        Text(periods[1])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .padding(.bottom, 16)
                    Toggle(isOn: $isEvening) {
                        Text(periods[2])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .padding(.bottom, 16)
                    Toggle(isOn: $isNight) {
                        Text(periods[3])
                            .font(.system(size: 17, weight: .medium))
                    }
                }
                .toggleStyle(CheckboxToggleStyle())
            }
            .font(.system(size: 24, weight: .bold))

            Section(header: Text("Показывать варианты с пересадками")) {
                VStack {
                    Toggle(isOn: $isYes) {
                        Text(yesNo[0])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .tag(0)
//                    .toggleStyle(RadioButtonStyle(tag: 0, isYes: $isYes, isNo: $isNo))
//                    .toggleStyle(RadioButtonStyle(tag: 0))
                    .padding(.bottom, 16)
                    Toggle(isOn: $isNo) {
                        Text(yesNo[1])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .tag(1)
//                    .toggleStyle(RadioButtonStyle(tag: 1, isYes: $isYes, isNo: $isNo))
//                    .toggleStyle(RadioButtonStyle(tag: 1))
                }
                    //                .padding(.bottom, 16)
            }
            .font(.system(size: 24, weight: .bold))
        }

            //        VStack(alignment: .leading) {
            //            Text("Время отправления")
            //                .font(.system(size: 24, weight: .bold))
            //            VStack {
            //                Toggle(isOn: $isMorning) {
            //                    Text(periods[0])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .toggleStyle(CheckboxToggleStyle())
            //                .padding(.bottom, 16)
            //                Toggle(isOn: $isDay) {
            //                    Text(periods[1])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .toggleStyle(CheckboxToggleStyle())
            //                .padding(.bottom, 16)
            //                Toggle(isOn: $isEvening) {
            //                    Text(periods[2])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .toggleStyle(CheckboxToggleStyle())
            //                .padding(.bottom, 16)
            //                Toggle(isOn: $isNight) {
            //                    Text(periods[3])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .toggleStyle(CheckboxToggleStyle())
            //                .padding(.bottom, 16)
            //            }
            //            Text("Показывать варианты с пересадками")
            //                .font(.system(size: 24, weight: .bold))
            //            VStack {
            //                Toggle(isOn: $isYes) {
            //                    Text(yesNo[0])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .tag(0)
            //                .toggleStyle(RadioButtonStyle(tag: 0, isYes: $isYes, isNo: $isNo))
            //                .padding(.bottom, 16)
            //                Toggle(isOn: $isNo) {
            //                    Text(yesNo[1])
            //                        .font(.system(size: 17, weight: .medium))
            //                }
            //                .tag(1)
            //                .toggleStyle(RadioButtonStyle(tag: 1, isYes: $isYes, isNo: $isNo))
            //                .padding(.bottom, 16)
            //
            //            }
            //        }
            //        .padding([.top, .horizontal], 16)
            //        .padding( 16)
            //        Spacer()
    }
}


    //                Picker("", selection: $withConnection) {
    //                    Text("Да").tag("Да")
    //                    Text("Нет").tag("Нет")
    //                }
    //                .pickerStyle(.palette)
    //                .padding()
    //
    //                Text("Selected \(withConnection)")

