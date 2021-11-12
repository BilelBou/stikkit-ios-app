//
//  UserModel.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 21/04/2021.
//

import Foundation

struct JWT: Decodable {
    let accessToken: String
    let expiresIn: Int
    let message: String
    let statusCode: Int
    
    enum CodingKeys: CodingKey {
        case accessToken, expiresIn, message, statusCode
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.accessToken = (try? container.decode(String.self, forKey: .accessToken)) ?? ""
        self.expiresIn = (try? container.decode(Int.self, forKey: .expiresIn)) ?? 0
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        self.statusCode = (try? container.decode(Int.self, forKey: .statusCode)) ?? 0
    }
}
