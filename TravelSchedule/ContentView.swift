//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 23.01.2025.
//

import SwiftUI
import OpenAPIURLSession
import OpenAPIRuntime

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .onAppear() {
            Task {
//                try betweenStations()
//                try stationSchedule()
//                try nearestStations()
//                try nearestSettlement()
//                try carriers()
//                try showCopyrightInfo()
                try showAllStations()
            }
        }
        .padding()
    }

    func showAllStations() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = AllStationService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            do {
                let allStationInfo = try await service.getAllStationList()
            // закомментировано, поскольку вешает XCode; полученный json выводится в файл
            // print(allStationInfo)
            } catch(let error) {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
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

    func betweenStations() throws {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )

        let service = ScheduleBetweenStationsService(
            client: client,
            apikey: "fb106596-6e67-468e-bcc3-15ab41f7fdca"
        )

        Task {
            do {
                let scheduleBetweenStations = try await service.getScheduleBetweenStations(from: "s9813094", to: "s9857050")
                print(scheduleBetweenStations)
            } catch(let error) {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
