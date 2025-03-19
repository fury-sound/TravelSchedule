import SwiftUI

struct FromToView: View {
    @Binding var path: [RouteView]
    @Binding var whereField: Int
    @ObservedObject var travelViewModel: TravelViewModel
    let screenSize = UIScreen.main.bounds

    var body: some View {
        HStack(spacing: 16) {
            HStack(alignment: .center) {
                VStack {
                    List {
                        HStack {
                            Button(action: {
                                whereField = 0
                                path.append(.locationView)
                            }) {
                                if travelViewModel.fromField.0 == "Откуда" {
                                    Text(travelViewModel.fromField.0)
                                        .foregroundStyle(Color.gray)
                                        .lineLimit(1)
                                } else {
                                    Text("\(travelViewModel.fromField.0) (\(travelViewModel.fromField.1))")
                                        .foregroundStyle(Color.black)
                                        .lineLimit(1)
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                        .listRowBackground(Color.white)
                        .padding(.top, 8)
                        .background(Color.white)
                        Button(action: {
                            whereField = 1
                            path.append(.locationView)
                        }) {
                            if travelViewModel.toField.0 == "Куда" {
                                Text(travelViewModel.toField.0)
                                    .foregroundStyle(Color.gray)
                                    .lineLimit(1)
                            } else {
                                Text("\(travelViewModel.toField.0) (\(travelViewModel.toField.1))")
                                    .foregroundStyle(Color.black)
                                    .lineLimit(1)
                            }
                        }
                        .listRowBackground(Color.white)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 8 )
                    }
                    .frame(height: 100)
                }
                .listStyle(.plain)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding([.top, .bottom], 16)
            Button(action: {
                travelViewModel.swapFromTo()
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
    @State var path = [RouteView.locationView]
    @State var whereField = 0
    @ObservedObject var travelViewModel = TravelViewModel()
    FromToView(path: $path, whereField: $whereField, travelViewModel: travelViewModel)
}

#Preview {
    @State var path = [RouteView.locationView]
    @State var whereField = 0
    @State var fromField = "Москва (Курский вокзал)"
    @State var toField = "Москва (Белорусский вокзал)"
    @ObservedObject var travelViewModel = TravelViewModel()
    FromToView(path: $path, whereField: $whereField, travelViewModel: travelViewModel)
        .preferredColorScheme(.dark)
}

#Preview {
    @State var path = [RouteView.locationView]
    @State var whereField = 0
    @State var fromField = "Москва (Курский вокзал)"
    @State var toField = "Москва (Белорусский вокзал)"
    @ObservedObject var travelViewModel = TravelViewModel()
    FromToView(path: $path, whereField: $whereField, travelViewModel: travelViewModel)
        .preferredColorScheme(.light)
}
