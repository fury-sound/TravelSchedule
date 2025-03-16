//
//  Carrier.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 15.02.2025.
//

import Foundation
import Combine

enum CarrierID: String, CaseIterable {
    case rzd = "РЖД"
    case fgk = "ФГК"
    case uralLogistika = "Урал логистика"
}

struct CarrierDetailsMock: Identifiable, Hashable {
    var id: UUID
    var name: CarrierID
    var nameLong: String
    var imageNameSmall: String
    var imageNameLarge: String?
    var email: String?
    var phone: String?
}

struct RouteDetailsCarrierMock: Hashable {
    var carrierDetails: CarrierDetailsMock
    var date: String
    var timeFrom: String
    var timeTo: String
    var timeTotal: String
    var connection: String?
}

//struct CarrierDetails: Hashable {
//    var name: String
//    var imageURL: String
//    var email: String
//    var phone: String
//}

struct RouteDetailsCarrier: Hashable {
    var carrier: Carrier
    var startDate: String
    var departureTime: String
    var arrivalTime: String
    var duration: String
    var connection: String?
}

//class CarrierModel: ObservableObject {
//    @Published var carriers: [CarrierDetails] = []
//    
//    init() {
//        loadCarriers()
//    }
//    
//    func loadCarriers() {
//        DispatchQueue.main.async() {
//            self.carriers = 
//        }
////        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////            self.carriers = CarrierID.allCases.compactMap {
////                
////            }
////        }
//    }
//}
