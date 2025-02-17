//
//  CarrierByCode.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 24.01.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias CarrierByCode = Components.Schemas.CarrierArray // Carrier //Carriers
//typealias CarrierByCode = Components.Schemas.Carrier //Carriers

protocol CarrierByCodeServiceProtocol {
    func getCarrierByCode(code: Int) async throws -> CarrierByCode
}

final class CarrierByCodeService: CarrierByCodeServiceProtocol {

    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getCarrierByCode(code: Int) async throws -> CarrierByCode {
        let response = try await client.getCarrierByCode(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }

}
