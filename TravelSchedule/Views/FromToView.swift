import SwiftUI

struct FromToView: View {
        //    @Binding var model: NavigationModel
    @Binding var path: [RouteView]
    @Binding var whereField: Int
        //    @State private var whereField: Int = 0
    @Binding var fromField: String
    @Binding var toField: String
        //    @State var routeDirectionFrom: Bool = true
        //    @Environment(RouteDirection.self) var routeDirection
        //    @Environment(\.routeDirection) private var routeDirection
        //    @EnvironmentObject var routeDirection: RouteDirection

    let screenSize = UIScreen.main.bounds
    var placeholders = ["Откуда", "Куда"]

    var body: some View {
        HStack(spacing: 16) {
            HStack {
                VStack(alignment: .center) {
                    List {
                        Button(action: {
//                            print("clicked, 0")
                            whereField = 0
                            path.append(.locationView)
                        }) {
                            if fromField == "Откуда" {
                                Text(fromField)
                                    .foregroundStyle(Color.gray)
                                    .lineLimit(1)
                            } else {
                                Text(fromField)
                                    .foregroundStyle(Color.ypBlack)
                                    .lineLimit(1)
                            }
                            }
                        Button(action: {
//                            print("clicked, 1")
                            whereField = 1
                            path.append(.locationView)
                        }) {
                            if toField == "Куда" {
                                Text(toField)
                                    .foregroundStyle(Color.gray)
                                    .lineLimit(1)
                            } else {
                                Text(toField)
                                    .foregroundStyle(Color.ypBlack)
                                    .lineLimit(1)
                            }
                            }
                        .listRowSeparator(.hidden)
                        Spacer()
                    }
                }
                .listStyle(.plain)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.top, 19)
            .padding(.bottom, 19)
            Button(action: {
//                print("Button pressed")
                if fromField != "Откуда" && toField != "Откуда" {
                    let temp = fromField
                    fromField = toField
                    toField = temp
                }
            }) {
                Image("changeButton")
                    .frame(width: 36, height: 36)
                    .background(Color.white)
                    .foregroundColor(.ypBlueUniversal)
                    .cornerRadius(25)
            }
        }
        .padding([.leading, .trailing], 16)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(.ypBlueUniversal)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: screenSize.width - 32, height: 128)
    }
}


#Preview {
        //    @Previewable @State var model = NavigationModel()
    @Previewable @State var path = [RouteView.locationView]
    @Previewable @State var whereField = 0
    @Previewable @State var fromField = ""
    @Previewable @State var toField = ""
        //    FromToView(path: $path, fromField: $fromField, toField: $toField)
    FromToView(path: $path, whereField: $whereField, fromField: $fromField, toField: $toField)
}

#Preview {
    @Previewable @State var path = [RouteView.locationView]
        //    @Previewable @State var model = NavigationModel()
    @Previewable @State var whereField = 0
    @Previewable @State var fromField = "Москва (Курский вокзал)"
    @Previewable @State var toField = "Москва (Белорусский вокзал)"
    FromToView(path: $path, whereField: $whereField, fromField: $fromField, toField: $toField)
        //    FromToView(path: $path, fromField: $fromField, toField: $toField)
}


    //    func hideChevron(completion: @escaping () -> Void) -> some View {
    //        NavigationLink(placeholders.first!, value: RouteView.locationView)
    //        opacity(0)
    //        return Text(placeholders.first!)
    //            .listRowSeparator(.hidden)
    ////            .foregroundStyle(Color.gray, Color.clear)
    //            .foregroundStyle(.placeholder)
    //            .onTapGesture {
    //                print(param)
    //            }

    //            .simultaneousGesture(TapGesture().onEnded{
    //                print(param)
    //                LocationSelection(headerText: "Выбор города", path: $path)
    //            })
    //    }

/*
 //                        var fromFieldText: String {
 //                            fromField.isEmpty ? placeholders.first! : fromField
 //                        }
 ZStack {
 NavigationLink(placeholders.first!, value: RouteView.locationView)
 .opacity(0)
 Text(placeholders.first!)
 //                                .listRowSeparator(.hidden)
 //            .foregroundStyle(Color.gray, Color.clear)
 //                                .foregroundStyle(.placeholder)
 .onTapGesture {
 print(param)
 }
 }
 */
/*
 if fromField == "" { //}.isEmpty {
 //                            hideChevron() {
 //                                param = "param1"
 //                                print(param)
 //                            }
 HStack {
 NavigationLink(placeholders.first!, value: RouteView.locationView)
 opacity(0)
 Text(placeholders.first!)
 .listRowSeparator(.hidden)
 //            .foregroundStyle(Color.gray, Color.clear)
 .foregroundStyle(.placeholder)
 .onTapGesture {
 print(param)
 }
 }
 //                            NavigationLink(placeholders.first!, value: RouteView.locationView)
 //                                //                            LocationSelection(headerText: "Выбор города", path: $path))
 //                                .foregroundStyle(Color.gray, Color.clear)
 //                                .listRowSeparator(.hidden)
 //                                .simultaneousGesture(TapGesture().onEnded({
 //                                        //  routeDirectionFrom = true
 //                                        //  routeFieldStatus = RouteFieldStatus.from
 //                                        //  routeDirection.routeFieldStatus = .from
 //                                    print("111")
 //                                    whereField = 0
 //                                    print("whereField in FromToView empty fromField", whereField)
 //                                }))
 //                                .foregroundStyle(.placeholder)
 //                            Text(placeholders.first!)
 //                                .foregroundStyle(.placeholder)
 //                                .listRowSeparator(.hidden)
 //                                .background(
 ////                                    NavigationLink("", value: RouteFieldStatus.from)
 //                                    NavigationLink("", destination: LocationSelection(headerText: "Выбор города", path: $path))
 //                                        .simultaneousGesture(TapGesture().onEnded({
 //                                    //  routeDirectionFrom = true
 //                                    //  routeFieldStatus = RouteFieldStatus.from
 //                                    //  routeDirection.routeFieldStatus = .from
 //                                            print("111")
 //                                            whereField = 0
 //                                            print("whereField in FromToView empty fromField", whereField)
 //                                        }))
 //                                        .opacity(0)
 //                                )
 } else {
 NavigationLink(fromField, value: RouteView.locationView)
 .foregroundStyle(Color.black, Color.clear)
 .listRowSeparator(.hidden)
 .lineLimit(1)
 //                            Text(fromField)
 //                                .lineLimit(1)
 //                                .listRowSeparator(.hidden)
 //                                .background(
 ////                                    NavigationLink(fromField, value: RouteFieldStatus.from)
 //                                    NavigationLink(fromField, destination: LocationSelection(headerText: "Выбор города", path: $path))
 //                                        .opacity(0)
 //                                        .simultaneousGesture(TapGesture().onEnded({
 //                                                //                                            routeDirectionFrom = true
 //                                                //                                    routeDirection.routeFieldStatus = .from
 //                                            print("222")
 //                                            whereField = 0
 //                                            print("whereField in FromToView filled fromField", whereField)
 //                                        }))
 //                                )
 }
 */
/*
 if toField == "" {
 Text(placeholders.last!)
 .foregroundStyle(.placeholder)
 .listRowSeparator(.hidden)
 .background(
 NavigationLink("", destination: LocationSelection(headerText: "Выбор города", path: $path))
 .opacity(0)
 .simultaneousGesture(TapGesture().onEnded({
 //                                            routeDirectionFrom = true
 //                                            routeFieldStatus = RouteFieldStatus.from
 //                                    routeDirection.routeFieldStatus = .from
 print("333")
 whereField = 1
 print("whereField in FromToView empty toField", whereField)
 }))
 )
 } else {
 Text(toField)
 .lineLimit(1)
 .listRowSeparator(.hidden)
 .background(
 NavigationLink(toField, destination: LocationSelection(headerText: "Выбор города", path: $path))
 .opacity(0)
 .simultaneousGesture(TapGesture().onEnded({
 print("444")
 //                                            routeDirectionFrom = true
 //                                            routeDirection.routeFieldStatus = .from
 whereField = 1
 print("whereField in FromToView filled toField", whereField)
 }))
 )
 }
 */
    //                        NavigationLink(placeholders.last!, destination: LocationSelection(headerText: "Выбор города", path: $path))
    //                            .foregroundStyle(.placeholder)

    //                        NavigationLink {
    //                            LocationSelection(headerText: "Выбор города", path: $path)
    //                        } label: {
    //                            if fromField == "" {
    //                                Text(placeholders.first!)
    //                                    .foregroundStyle(.placeholder)
    //                            } else {
    //                                Text(fromField)
    //                                    .lineLimit(1)
    //                            }
    //                        }
    //                        .listRowSeparator(.hidden)

    //                        .simultaneousGesture(TapGesture().onEnded({
    //                            print("in WhereField - FromToView")
    //                            print("path: \(path)")
    //                            path.append(.locationView)
    //                            print("path: \(path)")
    //                        }))

    //                        NavigationLink(placeholders.first!, destination: LocationSelection(headerText: "Выбор города", path: $path))
    ////                        NavigationLink(placeholders.first!, value: RouteView.locationView)
    //                            .navigationDestination(for: RouteView.self) { route in
    ////                                LocationSelection(headerText: "Выбор города", path: $path)
    ////                                StationSelection(header: "Выбор станции", path: $path)
    //                            }

