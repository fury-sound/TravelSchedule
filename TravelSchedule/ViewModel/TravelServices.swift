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

final class TravelServices: ObservableObject {

    @Published var travelDataAll: [Region] = []
    private var cancellables = Set<AnyCancellable>()
    var regions: [Region] = []

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

                let allStationInfo = try await service.getAllStationList()
                guard let russiaData = allStationInfo.countries?.first(where: { $0.title == "Россия" }) else {
                    print("Данные не получены")
                    return []
                }
                regions = russiaData.regions?.compactMap { region in
                    let settlements: [Settlement] = region.settlements?.compactMap { settlement in
                        let stations = settlement.stations?.compactMap { station in
                            Station(stationName: station.title ?? "Нет названия станции", stationType: station.station_type ?? "", transportType: station.transport_type ?? "", codes: StationCode(express: station.codes?.express ?? "", yandex: station.codes?.yandex ?? "", yandex_code: station.codes?.yandex_code ?? "", esr: station.codes?.esr ?? "", esr_code: station.codes?.esr_code ?? ""))
                        }
                        return Settlement(name: settlement.title ?? "Нет названия города", stations: stations ?? [])
                    } ?? []
                    return Region(name: region.title ?? "Нет названия региона", code: region.codes?.yandex_code ?? "Нет кода региона", settlements: settlements)
                } ?? []
                return regions
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

    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
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

        let scheduleBetweenStations = try await service.getScheduleBetweenStations(from: fromCode, to: toCode, transfers: true)
        let segments: [Segment] = scheduleBetweenStations.segments?.compactMap {segment in
                    let carrier: Carrier = Carrier(title: segment.thread?.carrier?.title ?? "Нет данных",
                                                   email: segment.thread?.carrier?.email ?? "Нет данных",
                                                   phone: segment.thread?.carrier?.phone ?? "Нет данных",
                                                   logo: segment.thread?.carrier?.logo ?? "",
                                                   logo_svg: segment.thread?.carrier?.logo_svg ?? "")
                    let thread: Thread = Thread(number: segment.thread?.number ?? "", carrier: carrier)

            return Segment(startDate: segment.start_date ?? "", departure: segment.departure ?? "", arrival: segment.arrival ?? "", duration: segment.duration ?? .zero, transfers: segment.has_transfers ?? false, thread: thread)
                } ?? []
        let sortedSegments = segments.sorted(by: {$0.startDate < $1.startDate})
        return sortedSegments
    }
}
