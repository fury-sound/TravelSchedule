    //
    //  RouteSettings.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

struct RouteSettings: View {
    @State private var isMorning = false
    @State private var isDay = false
    @State private var isEvening = false
    @State private var isNight = false
    @State private var isYes = false
    @State private var isNo = false
    @State private var yesNo = ["Да", "Нет"]
    @State private var periods = [
        "Утро 06:00 - 12:00",
        "День 12:00 - 18:00",
        "Вечер 18:00 - 00:00",
        "Ночь 00:00 - 06:00"
    ]
    @State private var withConnection: String = ""
    @Binding var filterConnection: Bool?
    @Environment(\.dismiss) var dismiss

    var body: some View {

        VStack(alignment: .leading) {
            Text("Время отправления")
                .font(.system(size: 24, weight: .bold))
            VStack {
                Toggle(isOn: $isMorning) {
                    Text(periods[0])
                        .font(.system(size: 17, weight: .medium))
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.bottom, 16)
                Toggle(isOn: $isDay) {
                    Text(periods[1])
                        .font(.system(size: 17, weight: .medium))
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.bottom, 16)
                Toggle(isOn: $isEvening) {
                    Text(periods[2])
                        .font(.system(size: 17, weight: .medium))
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.bottom, 16)
                Toggle(isOn: $isNight) {
                    Text(periods[3])
                        .font(.system(size: 17, weight: .medium))
                }
                .toggleStyle(CheckboxToggleStyle())
                .padding(.bottom, 16)
            }
            Text("Показывать варианты с пересадками")
                .lineLimit(2)
                .font(.system(size: 24, weight: .bold))
            VStack {
                Toggle(isOn: $isYes) {
                    Text(yesNo[0])
                        .font(.system(size: 17, weight: .medium))
                }
                .simultaneousGesture(TapGesture().onEnded{
                    filterConnection = true
//                    print("tag 0", filterConnection)
//                    print(filterConnection)
                })
                .tag(0)
                .toggleStyle(RadioButtonStyle(tag: 0, isYes: $isYes, isNo: $isNo))
                .padding(.bottom, 16)
                Toggle(isOn: $isNo) {
                    Text(yesNo[1])
                        .font(.system(size: 17, weight: .medium))
                }
                .simultaneousGesture(TapGesture().onEnded{
                    filterConnection = false
//                    print("tag 1", filterConnection)
//                    print(filterConnection)
                })

                .tag(1)
                .toggleStyle(RadioButtonStyle(tag: 1, isYes: $isYes, isNo: $isNo))
                .padding(.bottom, 16)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
            }
        }
        .padding(16)
        .onAppear {
//            print("filterConnection in .onAppear", filterConnection)
            switch filterConnection {
                case true:
                    isYes = true
                case false:
                    isNo = true
                default:
                    isYes = false
                    isNo = false
            }
        }
//        .padding([.top, .horizontal], 16)
        Spacer()
        if isYes || isNo {
            VStack {
                    //            Spacer()
//                NavigationLink(destination: RouteSettings(filterConnection: $filterConnection)) {
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
//                    print("filterConnection", filterConnection)
                    dismiss()
                }
            }
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
    @State var tag: Int?
    @Binding var isYes: Bool
    @Binding var isNo: Bool

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
                            if !isYes {
                                isYes = true
                                isNo = false
                            }
                        case 1:
                            if !isNo {
                                isNo = true
                                isYes = false
                            }
                        default:
                            break
                    }
                }
        }
    }
}



#Preview {
    @State var filterConnection: Bool? = false
    RouteSettings(filterConnection: $filterConnection)
}

#Preview {
    RouteSettingsWithForm()
}

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
    @State private var withConnection: String = ""

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
                    .toggleStyle(RadioButtonStyle(tag: 0, isYes: $isYes, isNo: $isNo))
                    .padding(.bottom, 16)
                    Toggle(isOn: $isNo) {
                        Text(yesNo[1])
                            .font(.system(size: 17, weight: .medium))
                    }
                    .tag(1)
                    .toggleStyle(RadioButtonStyle(tag: 1, isYes: $isYes, isNo: $isNo))
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

