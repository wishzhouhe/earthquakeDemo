//
//  EarthquakeModel.swift
//  earthquake
//
//  Created by Zhou on 2024/11/6.
//

import Foundation

// 地震模型，用于存储从 API 获取的数据
struct EarthquakeModel: Decodable {
    let id: String
    let place: String
    let magnitude: Double
    let latitude: Double
    let longitude: Double
}
