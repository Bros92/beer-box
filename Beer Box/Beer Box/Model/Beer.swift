//
//  Beer.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation
import UIKit

struct Beer: Codable, Hashable {
    
    enum BeerCodingKeys: String, CodingKey {
        case id, name, tagline, ingredients
        case infoDescription = "description"
        case imageUrl = "image_url"
        case foodPairing = "food_pairing"
    }
    
    /// The unique identifier of beer
    /// I added this prameter to be sure that the model will be an unique value
    var uuid = UUID().uuidString
    /// The id of beer
    let id: Int
    /// The name of beer
    let name: String
    /// The tagline of beer
    let tagline: String
    /// The description of beer
    let infoDescription: String
    /// The image url of beer
    let imageUrl: String?
    /// The ingredients of beer
    let ingredients: Ingredients
    /// The possible food pairing
    let foodPairing: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BeerCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.infoDescription = try container.decode(String.self, forKey: .infoDescription)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        self.ingredients = try container.decode(Ingredients.self, forKey: .ingredients)
        self.foodPairing = try container.decode([String].self, forKey: .foodPairing)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}

struct Ingredients: Codable, Equatable {
    var malt: [Malt]
    var hops: [Hop]
}

struct Malt: Codable, Hashable, Equatable {
    var name: String
    var amount: Amount
}

struct Amount: Codable, Hashable, Equatable {
    var value: Double
    var unit: String
}

struct Hop: Codable, Hashable, Equatable {
    var name: String
    var amount: Amount
    var add: String
    var attribute: String
}

enum BeerType: String, CaseIterable, Hashable {
    
    case lager = "Lager"
    case stout = "Stout"
    case blonde = "Blonde"
    case pale = "Pale"
    case pilsner = "Pilsner"
    
    var localizedType: String {
        switch self {
        case .lager:
            return "LAGER".localized
        case .stout:
            return "STOUT".localized
        case .blonde:
            return "BLODE".localized
        case .pale:
            return "PALE".localized
        case .pilsner:
            return "PILSNER".localized
        }
    }
}
