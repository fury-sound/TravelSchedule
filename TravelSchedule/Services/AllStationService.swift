    //
    //  AllStationService.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 27.01.2025.
    //

import OpenAPIRuntime
import OpenAPIURLSession
import SwiftUI

typealias AllStationList = Components.Schemas.Station_list

protocol AllStationServiceProtocol {
    func getAllStationList() async throws -> AllStationList
}

final class AllStationService: AllStationServiceProtocol {
    private let client: Client
    private let apikey: String

    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }

    func getAllStationList() async throws -> AllStationList {
        let response = try await client.getAllStationList(query: .init(apikey: apikey))

        let responseBody = try response.ok.body.text_html_charset_utf_hyphen_8
        let data = try await Data(collecting: responseBody, upTo: 50 * 1024 * 1024)
        let allStations = try JSONDecoder().decode(AllStationList.self, from: data)

            //##########################
            // MARK: To check the data is actually received
            // Encode allStations to JSON and store it in a file
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // Optional: for human-readable format
        let json = try encoder.encode(allStations)
            // Create a file path
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
        {
            return allStations
        }
        let fileURL = documentsDirectory.appendingPathComponent("allStations.json")
            // Write JSON to the file
//        try json.write(to: fileURL, options: .atomicWrite)
//        print("Сохраняем JSON в файл по указанному ниже пути:")
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path)
            //##########################

        return allStations
    }
}
