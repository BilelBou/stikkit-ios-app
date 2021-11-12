import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let image: String
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Group
struct Group: Codable {
    let createdAt, id, ownerID, name: String
    let users: [Welcome]

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case ownerID = "ownerId"
        case name, users
    }
}

// MARK: - Welcome
struct Welcome: Codable {
    let createdAt, id, groupID, firstName: String
    let lastName, email: String
    let phone, address: JSONNull?
    let image, password: String
    let group: Group?
    let stickers: [Sticker]?

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case groupID = "groupId"
        case firstName, lastName, email, phone, address, image, password, group, stickers
    }
}

// MARK: - Sticker
struct Sticker: Codable, Hashable {
    let createdAt, id, ownerID: String
    let lastLongitude, lastLatitude: JSONNull?
    let lastPositionDate: String

    enum CodingKeys: String, CodingKey {
        case createdAt, id
        case ownerID = "ownerId"
        case lastLongitude, lastLatitude, lastPositionDate
    }
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
