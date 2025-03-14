    //
    //  WhereToModel.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 09.02.2025.
    //

import Foundation

struct FromToModel: Hashable {
    var fromField: String = "Откуда"
    var toField: String = "Куда"
}

struct RouteModel {
    var departureCity: String = ""
    var departureStation: String = ""
    var destinationCity: String = ""
    var destinationStation: String = ""
    var departureDate: String = ""
    var departureTime: String = ""
    var arrivalDate: String = ""
    var arrivalTime: String = ""
}

//struct Station {
//    var stationName: String = ""
//}

enum RouteView: Hashable {
    case locationView
    case stationView(CityList)
}

enum MoscowTerminal: String, CaseIterable {
    case belorusskyVokzal = "Белорусский вокзал"
    case kievskyVokzal = "Киевский вокзал"
    case kurskyVokzal = "Курский вокзал"
    case leningradskyVokzal = "Ленинградский вокзал"
    case savelosvskyVokzal = "Савеловский вокзал"
    case yaroslavskyVokzal = "Ярославский вокзал"
}

enum PetersburgTerminal: String, CaseIterable {
    case baltiyskyVokzal = "Балтийский вокзал"
    case ladozhskyVokzal = "Ладожский вокзал"
    case moskovskyVokzal = "Московский вокзал"
    case varshavskyVokzal = "Варшавский вокзал"
}

enum SochiTerminal: String, CaseIterable {
    case sochiVokzal = "Сочи вокзал"
}

enum AnyCityTerminal: String, CaseIterable {
    case cityVokzal = "Городской ж/д вокзал"
}

enum CityList: Hashable, CaseIterable {
    case moscow
    case stPetersburg
    case sochi
    case gornyVozduh
    case krasnodar
    case kazan
    case omsk

    var cityName: String {
        return switch self {
            case .moscow: "Москва"
            case .stPetersburg: "Санкт-Петербург"
            case .sochi: "Сочи"
            case .gornyVozduh: "Горный воздух"
            case .krasnodar: "Краснодар"
            case .kazan: "Казань"
            case .omsk: "Омск"
        }
    }

    var stations: [String] {
        return switch self {
            case .moscow: MoscowTerminal.allCases.map( \.rawValue )
            case .stPetersburg: PetersburgTerminal.allCases.map( \.rawValue )
            case .sochi: SochiTerminal.allCases.map( \.rawValue )
            case .gornyVozduh: AnyCityTerminal.allCases.map( \.rawValue )
            case .krasnodar: AnyCityTerminal.allCases.map( \.rawValue )
            case .kazan: AnyCityTerminal.allCases.map( \.rawValue )
            case .omsk: AnyCityTerminal.allCases.map( \.rawValue )
        }
    }
}
