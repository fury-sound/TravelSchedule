    //
    //  CarrierCard.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 16.02.2025.
    //

import SwiftUI

struct CarrierCard: View {
    @State var carrierDetails: CarrierDetails = CarrierDetails(id: .rzd, name: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")
    let carrierDetailsCheck: CarrierDetails = CarrierDetails(id: .rzd, name: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")

    var body: some View {
//        Text("on RZD page: \(carrierDetailsCheck.imageNameLarge), \(carrierDetailsCheck.email), \(carrierDetailsCheck.phone)")

        if
            let image = carrierDetailsCheck.imageNameLarge,
            let email = carrierDetailsCheck.email,
            let phone = carrierDetailsCheck.phone {

            VStack(alignment: .leading) {
                Image(image)
                    .padding(16)
                Text(carrierDetailsCheck.name)
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 16)
                VStack(alignment: .leading) {
                    Text("E-mail")
                        .font(.system(size: 17, weight: .regular))
                    Text(email)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
                .padding(.bottom, 16)
                VStack(alignment: .leading) {
                    Text("Телефон")
                        .font(.system(size: 17, weight: .regular))
                    Text(phone)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(.ypBlueUniversal)
                }
            }
            .padding([.leading, .bottom], 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonView()
                }
            }
            Spacer()
//                .onAppear {
//                    print(carrierDetails.imageNameLarge,
//                          carrierDetails.email,
//                          carrierDetails.phone)
//                }
        }
    }
}

#Preview {
    let carrierDetails: CarrierDetails = CarrierDetails(id: .rzd, name: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")
    CarrierCard(carrierDetails: carrierDetails)
//    CarrierCard()
}
