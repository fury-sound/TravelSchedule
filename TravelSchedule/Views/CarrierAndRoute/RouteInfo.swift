    //
    //  RouteInfo.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI
import Kingfisher

struct RouteInfo: View {
    let screenSize = UIScreen.main.bounds
    @State var routeDetailsCarrier: RouteDetailsCarrier

    var body: some View {
        NavigationLink(destination: CarrierCard(carrier: routeDetailsCarrier.carrier)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.ypLightGray)
                        .overlay(
                            VStack {
                                HStack {
                                    KFImage(URL(string: routeDetailsCarrier.carrier.logo))
                                        .placeholder {
                                            Image(ImageResource.ypClose)
                                                .resizable()
                                                .frame(width: 38, height: 38)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                        }
                                        .resizable()
                                        .frame(width: 38, height: 38)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    VStack(alignment: .leading) {
                                        Text(routeDetailsCarrier.carrier.title)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 17, weight: .regular))
                                        if let connection = routeDetailsCarrier.connection {
                                            Text(connection)
                                                .foregroundColor(.ypRed)
                                                .font(.system(size: 12, weight: .regular))
                                        }
                                    }
                                    Spacer()
                                    Text(routeDetailsCarrier.startDate)                                    .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .padding(.top, 14)
                                Spacer()
                                HStack {
                                    Text(routeDetailsCarrier.departureTime)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 17, weight: .regular))
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .foregroundColor(.ypGrayUniversal)
                                    Text(routeDetailsCarrier.duration)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .regular))
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .foregroundColor(.ypGrayUniversal)
                                    Text(routeDetailsCarrier.arrivalTime)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 17, weight: .regular))
                                }
                                .padding(.bottom, 14)
                            }
                                .padding([.leading, .trailing], 14)
                        )
                }
                .frame(maxWidth: .infinity, minHeight: screenSize.height / 7, maxHeight: screenSize.height / 7)
            }
        }
}


#Preview {
    let travelViewModel = TravelViewModel()
    @State var routeDetailsCarrier: RouteDetailsCarrier =
    CacheStorage.shared.carrierArray[0]
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}

#Preview {
    let travelViewModel = TravelViewModel()
    @State var routeDetailsCarrier: RouteDetailsCarrier = CacheStorage.shared.carrierArray[1]
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}

