//
//  TravelServices.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 09.02.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime
import Combine

//final class TravelServices {
final class TravelServices: ObservableObject {

    @Published var travelDataAll: [Region] = []
    private var cancellables = Set<AnyCancellable>()
    var regions: [Region] = []

//    @Published var travelDataList: [Region] = []
//    @Published var travelCityList: [Settlement] = []
//    @Published var travelStationList: [Station] = []

    //    @Published var fromField: String = "Откуда"
    //    @Published var toField: String = "Куда"
    //    @Published var whereField: Int = 0

//    func getCityList() { //} -> [String] {
//                         //        var cityList: [String] = []
//        for region in travelDataList {
//            region.settlements.forEach { settlement in
//                travelCityList.append(settlement.name)
//            }
//        }
//        //        print(cityList)
//                print("travelDataList.count", travelDataList.count)
//                print("travelCityList.count", travelCityList.count)
//        //        return []
//    }

//    func getCityList() { //-> [String] {
////        var cityNameSet: Set<String> = []
//        for region in travelDataList {
//            region.settlements.forEach { settlement in
//                if !settlement.name.isEmpty {
//                    travelCityList.append(settlement)
//                }
////                    settlement.stations.forEach { station in
////                        if !station.codes.yandex_code.isEmpty && station.transportType == "train" {
//////                            cityNameSet.insert(settlement.name)
////                        }
////                    }
////                }
//            }
//        }
//        
//        print("travelCityList.count in getCityList", travelCityList.count)
//    }
//
//    func getStationList(cityName: String) { //-> [String] {
//        let settlementToSearch = travelCityList.filter { $0.name == cityName }
//        settlementToSearch.forEach { settlement in
//            settlement.stations.forEach { station in
//                if station.transportType == "train" && !station.codes.yandex_code.isEmpty {
//                    travelStationList.append(station)
//                }
//            }
//
//            //        for region in travelDataList {
//            //            region.settlements.forEach { settlement in
//            //                if settlement.name == cityName {
//            //                    settlement.stations.forEach { station in
//            //                        if !station.codes.yandex_code.isEmpty && station.transportType == "train" {
//            //                            travelStationList.append(station)
//            //                            print("1", station.stationType, "2", station.transportType)
//            //                        }
//            //                    }
//            //                }
//            //            }
//            //        }
//            //        print("travelStationList.count in getStationList", travelStationList.count)
//        }
//    }

    func showStationsOnRoute() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = StationOnRouteService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            let stations = try await service.getStationsOnRoute(uid: "empty_0_f9813109t9878648_175")
            print(stations)
        }
    }

    func showAllStations() async throws -> [Region] {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = AllStationService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

//        Task {
//            do {
                let allStationInfo = try await service.getAllStationList()
                guard let russiaData = allStationInfo.countries?.first(where: { $0.title == "Россия" }) else {
                    print("No data found")
                    return []
                }
//                print(russiaData.title)
                regions = russiaData.regions?.compactMap { region in
                    //                    travelDataList = russiaData.regions?.compactMap { region in
                    let settlements: [Settlement] = region.settlements?.compactMap { settlement in
                        let stations = settlement.stations?.compactMap { station in
                            Station(stationName: station.title ?? "Нет названия станции", stationType: station.station_type ?? "", transportType: station.transport_type ?? "", codes: StationCode(express: station.codes?.express ?? "", yandex: station.codes?.yandex ?? "", yandex_code: station.codes?.yandex_code ?? "", esr: station.codes?.esr ?? "", esr_code: station.codes?.esr_code ?? ""))
                        }
                        return Settlement(name: settlement.title ?? "Нет названия города", stations: stations ?? [])
                    } ?? []
                    return Region(name: region.title ?? "Нет названия региона", code: region.codes?.yandex_code ?? "Нет кода региона", settlements: settlements)
                } ?? []
                return regions
                //                                print(travelDataList.count)
                //                                travelViewModel.getCityList()
//                await MainActor.run {
//                    print("regions.count", regions.count)
//                    self.travelDataAll = regions
////                    getCityList()
//                }
                //                print(regions)
//                for region in regions {
////                    print(region.settlements.count)
//                    for settlement in region.settlements {
//                        if settlement.name == "Санкт-Петербург" {
//                            print(settlement.name)
//                            print(settlement.stations.count)
////                            for station in settlement.stations {
////                                print(station.stationName, "-", station.codes)
////                            }
//                        }
//                    }
//                }

                // закомментировано, поскольку вешает XCode; полученный json выводится в файл
                // print(allStationInfo)

//            } catch(let error) {
//                print("An error occurred: \(error.localizedDescription)")
//            }
//        }
//        print("regions.count", regions.count)
//        return regions
    }

    func showCopyrightInfo() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = CopyrightService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            do {
                let copyrightData = try await service.getCopyright()
                print(copyrightData)
            } catch(let error) {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }

    func stationSchedule() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = ScheduleByStationService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            do {
                let stations = try await service.getScheduleByStation(station: "s9600213")
                print(stations)
            } catch(let error) {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }

    func nearestStations() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = NearestStationsService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            let stations = try await service.getNearestStations(lat: 59.864177, lng: 30.319163, distance: 25)
            print(stations)
        }
    }

    func nearestSettlement() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = NearestSettlementService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            let settlement = try await service.getNearestSettlement(lat: 59.864177, lng: 30.319163)
            print(settlement)
        }
    }

    func carriers() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = CarrierByCodeService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            do {
                let myCarrier = try await service.getCarrierByCode(code: 680)
                print(myCarrier)
            } catch(let error) {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }

    func betweenStations(_ fromCode: String, _ toCode: String) async throws -> [Segment] {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = ScheduleBetweenStationsService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

//        Task {
//            do {
//                let scheduleBetweenStations = try await service.getScheduleBetweenStations(from: "s9602494", to: "s9623135")
//                let scheduleBetweenStations = try await service.getScheduleBetweenStations(from: "s9813094", to: "s9857050")
//                print(scheduleBetweenStations.segments?.count, scheduleBetweenStations.interval_segments?.count)
        let scheduleBetweenStations = try await service.getScheduleBetweenStations(from: fromCode, to: toCode)
        let segments: [Segment] = scheduleBetweenStations.segments?.compactMap {segment in
                    let carrier: Carrier = Carrier(title: segment.thread?.carrier?.title ?? "",
                                                   email: segment.thread?.carrier?.email ?? "",
                                                   phone: segment.thread?.carrier?.phone ?? "",
                                                   logo: segment.thread?.carrier?.logo ?? "",
                                                   logo_svg: segment.thread?.carrier?.logo_svg ?? "")
                    let thread: Thread = Thread(number: segment.thread?.number ?? "", carrier: carrier)

                    return Segment(startDate: segment.start_date ?? "", departure: segment.departure ?? "", arrival: segment.arrival ?? "", duration: (Double(segment.duration ?? 0) / 3600.0).rounded(.up), transfers: segment.has_transfers ?? false, thread: thread)
                } ?? []
//                print(segments)
                return segments

//            } catch(let error) {
//                print("An error occurred: \(error.localizedDescription)")
//            }
//        }
    }
}
