//
//  ScheduleBetweenStationsService.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 25.01.2025.
//

//MARK: комментированный текст оставлен для дальнейшей разработки алгоритма фильтрации 

    // 1. Импортируем библиотеки
import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

    // 2. Улучшаем читаемость кода — необязательный шаг
typealias ScheduleBetweenStations = Components.Schemas.Search

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, transfers: Bool) async throws -> ScheduleBetweenStations
//    func getScheduleBetweenStations(from: String, to: String, date: String, transfers: Bool) async throws -> ScheduleBetweenStations
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

//    func getScheduleBetweenStations(from: String, to: String, date: String, transfers: Bool) async throws -> ScheduleBetweenStations {
    func getScheduleBetweenStations(from: String, to: String, transfers: Bool) async throws -> ScheduleBetweenStations {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
//            date: date,
            transfers: transfers
        ))
        return try response.ok.body.json
    }
}
