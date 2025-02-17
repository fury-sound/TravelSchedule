    //
    //  RouteInfo.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

struct RouteInfo: View {
    let screenSize = UIScreen.main.bounds
        //    let routeDetailsCarrier: RouteDetailsCarrier
    @State var routeDetailsCarrier: RouteDetailsCarrier

    var body: some View {
//        NavigationStack {
            NavigationLink(destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.ypLightGray)
                        .overlay(
                            VStack {
                                HStack {
                                    Image(routeDetailsCarrier.carrierDetails.imageNameSmall)
                                    VStack(alignment: .leading) {
                                        Text(routeDetailsCarrier.carrierDetails.id.rawValue)
                                            .foregroundColor(Color.black)
                                            .font(.system(size: 17, weight: .regular))
                                        if let connection = routeDetailsCarrier.connection {
                                            Text(connection)
                                                .foregroundColor(.ypRed)
                                                .font(.system(size: 12, weight: .regular))
                                        }
                                    }
                                    Spacer()
                                    Text(routeDetailsCarrier.date)                                    .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .regular))
                                }
                                .padding(.top, 14)
                                Spacer()
                                HStack {
                                    Text(routeDetailsCarrier.timeFrom)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 17, weight: .regular))
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .foregroundColor(.ypGrayUniversal)
                                    Text(routeDetailsCarrier.timeTotal)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 14, weight: .regular))
                                    Rectangle()
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                        .foregroundColor(.ypGrayUniversal)
                                    Text(routeDetailsCarrier.timeTo)
                                        .foregroundColor(Color.black)
                                        .font(.system(size: 17, weight: .regular))
                                }
                                .padding(.bottom, 14)
                            }
                                .padding([.leading, .trailing], 14)
                        )
                }
                .frame(maxWidth: .infinity, minHeight: screenSize.height / 7, maxHeight: screenSize.height / 7)
//                .onTapGesture {
//                    print("tapped")
//                    NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
//                }
            }
        }
//        NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
//    }
}
    //        .navigationDestination(for: <#T##Hashable.Type#>, destination: <#T##(Hashable) -> View#>)
    //        .onTapGesture {
    //            print("tapped")
    //            NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
    //        }
    //    }
    //}

#Preview {
    let routeCarrierData = RouteCarrierData()
    @State var routeDetailsCarrier: RouteDetailsCarrier = routeCarrierData.mockRouteArray.first!
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}

#Preview {
    let routeCarrierData = RouteCarrierData()
    @State var routeDetailsCarrier: RouteDetailsCarrier = routeCarrierData.mockRouteArray[2]
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}
