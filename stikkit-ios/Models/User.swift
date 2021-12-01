// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct User: Codable {
    let createdAt, id, firstName: String
    let groupID: String?
    let lastName, email: String
    let phone, address: String?
    let image, password: String
    let group: Group?
    let stickers: [Sticker]?

    enum CodingKeys: String, CodingKey {
        case createdAt, id, firstName
        case groupID = "groupId"
        case lastName, email, phone, address, image, password, group, stickers
    }
}

// MARK: - Group
struct Group: Codable {
    let createdAt, id, ownerID, name: String?
    let users: [User]?

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case ownerID = "ownerId"
        case name, users
    }
}

// MARK: - Sticker
struct Sticker: Codable, Hashable {
    let createdAt, id, ownerID, name: String
    let position: Position?
    let lastPositionDate: String

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case ownerID = "ownerId"
        case name, position, lastPositionDate
    }
}

// MARK: - Position
struct Position: Codable, Hashable {
    let latitude, longitude: Double
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
