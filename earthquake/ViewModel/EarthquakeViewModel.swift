//
//  EarthquakeViewModel.swift
//  earthquake
//
//  Created by Zhou on 2024/11/6.
//

import Foundation


// 地震信息的结构体
struct EarthquakeResponse: Decodable {
    let features: [Feature]
    
    struct Feature: Decodable {
        let id: String
        let properties: Properties
        let geometry: Geometry
        
        struct Properties: Decodable {
            // 位置
            let place: String
            // 震级
            let mag: Double
        }
        
        struct Geometry: Decodable {
            let coordinates: [Double]
        }
    }
}


class EarthquakeViewModel {
    private var earthquakes: [EarthquakeModel] = []
    
    func fetchEarthquakes(completion: @escaping () -> Void) {
        let urlString = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2023-01-01&endtime=2024-01-01&minmagnitude=7"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(EarthquakeResponse.self, from: data)
                    
                    // 将 EarthquakeResponse 转换为 Earthquake 数组
                    self.earthquakes = response.features.map { feature in
                        EarthquakeModel(
                            id: feature.id,
                            place: feature.properties.place,
                            magnitude: feature.properties.mag,
                            latitude: feature.geometry.coordinates[1],
                            longitude: feature.geometry.coordinates[0]
                        )
                    }
                    
                    DispatchQueue.main.async {
                        completion()
                    }
                } catch {
                    print("解码错误：\(error)")
                }
            }
        }.resume()
    }
    
    func numberOfEarthquakes() -> Int {
        return earthquakes.count
    }
    
    func earthquake(at index: Int) -> EarthquakeModel {
        return earthquakes[index]
    }
}


