    //
    //  CarrierCard.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 16.02.2025.
    //

import SwiftUI

struct CarrierCard: View {
    @State var carrierDetails: CarrierDetails = CarrierDetails(id: UUID(), name: .rzd, nameLong: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")
    let carrierDetailsCheck: CarrierDetails = CarrierDetails(id: UUID(), name: .rzd, nameLong: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")

    var body: some View {

        VStack {
            if
                let image = carrierDetailsCheck.imageNameLarge,
                let email = carrierDetailsCheck.email,
                let phone = carrierDetailsCheck.phone {

                VStack(alignment: .leading) {
                    Image(image)
                        .padding(16)
                    Text(carrierDetailsCheck.nameLong)
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
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButtonView()
                    }
                }
                .padding([.leading, .bottom], 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationTitle("Информация о перевозчике").navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                Spacer()
            }
        }
        .background(Color.ypWhite)
    }
}

#Preview {
    let carrierDetails: CarrierDetails = CarrierDetails(id: UUID(), name: .rzd, nameLong: "ОАО РЖД", imageNameSmall: "rzd", imageNameLarge: "rzdLarge", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00")
    CarrierCard(carrierDetails: carrierDetails)
        //    CarrierCard()
}
