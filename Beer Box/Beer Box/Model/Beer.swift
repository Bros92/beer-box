//
//  Beer.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

struct Beer: Codable, Hashable {
    
    enum BeerCodingKeys: String, CodingKey {
        case id, name, tagline
        case infoDescription = "description"
        case imageUrl = "image_url"
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
    let imageUrl: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BeerCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.infoDescription = try container.decode(String.self, forKey: .infoDescription)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.uuid)
    }
}
