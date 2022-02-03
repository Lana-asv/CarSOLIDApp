//
//  Car.swift
//  CarAppSOLID
//
//  Created by Sveta on 03.12.2021.
//

import Foundation
import UIKit

struct Car {
    let body: Body
    let image: String
    let price: String
}

extension Car {
    enum Body: String, Codable {
        case hatchback
        case sedan
        case crossover
        case minivan
        
        func localized() -> String {
            switch self {
            case .sedan:
                return "Cедан"
            case .hatchback:
                return "Хэтчбек"
            case .crossover:
                return "Кроссовер"
            case .minivan:
                return "Минивэн"
            default:
                return ""
            }
        }
    }
}

extension Car: Codable {
}

extension Car {
    
    static func loadCarModels() -> [String] {
        let carInstance = self.loadJSON(filename: "cars")
        return carInstance.keys.sorted()
    }
    
    static func loadCars(key: String) -> [Car] {
        let carModel = self.loadJSON(filename: "cars")
        return carModel[key] ?? []
    }
    
    static func loadJSON(filename fileName: String) -> [String: [Car]] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return [:]
        }

        do {
            let data = try Data(contentsOf: url)
            let jsonData = try JSONDecoder().decode([String: [Car]].self, from: data)
            return jsonData
        } catch {
            }
        return [:]
    }
}
