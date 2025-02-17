//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 25.01.2025.
//

    // 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

    // 2. Улучшаем читаемость кода — необязательный шаг
typealias ScheduleBetweenStations = Components.Schemas.Search

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getScheduleBetweenStations(from: String, to: String) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
        ))
        return try response.ok.body.json
    }
}
