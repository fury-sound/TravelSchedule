    //
    //  RouteInfo.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 15.02.2025.
    //

import SwiftUI

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
//                                    Image(routeDetailsCarrier.carrier.logo)
                                    Image(ImageResource.rzd)
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
    let routeCarrierData = RouteCarrierData()
    @State var routeDetailsCarrier: RouteDetailsCarrier = routeCarrierData.selectedRouteArray.first!
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}

#Preview {
    let travelViewModel = TravelViewModel()
    let routeCarrierData = RouteCarrierData()
    @State var routeDetailsCarrier: RouteDetailsCarrier = routeCarrierData.selectedRouteArray[2]
    RouteInfo(routeDetailsCarrier: routeDetailsCarrier)
}


    //                .onTapGesture {
    //                    print("tapped")
    //                    NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
    //                }
    //        NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
    //    }

    //        .navigationDestination(for: <#T##Hashable.Type#>, destination: <#T##(Hashable) -> View#>)
    //        .onTapGesture {
    //            print("tapped")
    //            NavigationLink("", destination: CarrierCard(carrierDetails: routeDetailsCarrier.carrierDetails))
    //        }
    //    }
//}
