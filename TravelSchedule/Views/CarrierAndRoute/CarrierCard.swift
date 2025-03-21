//
//  CarrierCard.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 16.02.2025.
//

import SwiftUI
import Kingfisher

struct CarrierCard: View {
    let carrier: Carrier

    init(carrier: Carrier) {
        self.carrier = carrier
    }

    var body: some View {
        VStack(alignment: .center) {
            let image = KFImage(URL(string: carrier.logo))
                .placeholder {
                    Image(ImageResource.ypClose)
                        .resizable()
                        .frame(maxHeight: 104)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .resizable()
                .frame(maxHeight: 104)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal, 25)
                let email = carrier.email
                let phone = carrier.phone

                VStack(alignment: .leading) {
                    image
                        .padding(16)
                    Text(carrier.title)
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
//            }
        }
        .background(Color.ypWhite)
    }
}

#Preview {
    let image = Image("rzd")
    let carrier: Carrier = Carrier(title: "РЖД/ФПС", email: "ticket@rzd.ru", phone: "+7 (499) 605-20-00", logo: "https://yastat.net/s3/rasp/media/data/company/logo/logo.gif")
    CarrierCard(carrier: carrier)
}
