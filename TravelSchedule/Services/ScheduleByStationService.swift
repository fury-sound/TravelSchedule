//
//  ScheduleByStationService.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 25.01.2025.
//

    // 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession

    // 2. Улучшаем читаемость кода — необязательный шаг
typealias StationSchedule = Components.Schemas.Schedule

protocol ScheduleByStationServiceProtocol {
    func getScheduleByStation(station: String) async throws -> StationSchedule
}

final class ScheduleByStationService: ScheduleByStationServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getScheduleByStation(station: String) async throws -> StationSchedule {
            // В документе с описанием запроса мы задали параметры apikey, lat, lng и distance
            // Для вызова сгенерированной функции нужно передать эти параметры
        let response = try await client.getScheduleByStation(query: .init(
            apikey: apikey,
            station: station
        ))
        return try response.ok.body.json
    }
}
