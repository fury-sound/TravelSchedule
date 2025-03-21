//
//  CacheStorage.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 18.03.2025.
//

import Foundation

final class CacheStorage {
    static let shared = CacheStorage()
    var carrierArray: [RouteDetailsCarrier] = []
}
