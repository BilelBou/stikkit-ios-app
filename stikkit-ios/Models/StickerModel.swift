//
//  StickerModel.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 22/04/2021.
//

import Foundation

struct stickerModel: Decodable {
    let id: Int
    let ownerId: Int
    let stickerId: String
    let lastPosition: Int
    let creationDate: String
    let lastPositionDate: String
    
    enum CodingKeys: CodingKey {
        case id, ownerId, stickerId, lastPosition, creationDate, lastPositionDate
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.ownerId = (try? container.decode(Int.self, forKey: .ownerId)) ?? 0
        self.stickerId = (try? container.decode(String.self, forKey: .stickerId)) ?? ""
        self.lastPosition = (try? container.decode(Int.self, forKey: .lastPosition)) ?? 0
        self.creationDate = (try? container.decode(String.self, forKey: .creationDate)) ?? ""
        self.lastPositionDate = (try? container.decode(String.self, forKey: .lastPositionDate)) ?? ""
    }
}
