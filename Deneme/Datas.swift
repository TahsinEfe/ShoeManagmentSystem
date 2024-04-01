//
//  Datas.swift
//  Deneme
//
//  Created by Intala Lab on 30.03.2024.
//

import Foundation

struct Shoe: Codable, Identifiable {
        let id: Int
        let brand: String
        let model: String
        let size: Int
        let colour: String
        let price: Double

        private enum CodingKeys: String, CodingKey {
            case id = "ShoeId"
            case brand = "ShoeBrand"
            case model = "ShoeModel"
            case size = "ShoeSize"
            case colour = "ShoeColour"
            case price = "ShoePrice"
        }
}
