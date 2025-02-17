//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 26.01.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias CopyrightInfo = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> CopyrightInfo
}

final class CopyrightService: CopyrightServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCopyright() async throws -> CopyrightInfo {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}
