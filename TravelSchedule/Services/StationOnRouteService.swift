//
//  StationOnRouteService.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 27.01.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias StationsOnRoute = Components.Schemas.Stations_on_route

protocol StationOnRouteServiceProtocol {
    func getStationsOnRoute(uid: String) async throws -> StationsOnRoute
}

final class StationOnRouteService: StationOnRouteServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getStationsOnRoute(uid: String) async throws -> StationsOnRoute {
        let response = try await client.getStationOnRoute(query: .init(
            apikey: apikey,
            uid: uid
        ))
        return try response.ok.body.json
    }
}
