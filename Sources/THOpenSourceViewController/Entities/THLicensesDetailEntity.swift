//
//  File.swift
//  
//
//  Created by 유태훈 on 2023/10/05.
//

import Foundation

struct THLicenseDetailEntity: Codable {
    var key, name, spdxID: String?
    var url: String?
    var nodeID: String?
    var htmlURL: String?
    var description, implementation: String?
    var permissions, conditions, limitations: [String]?
    var body: String?
    var featured: Bool?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID
        case url
        case nodeID
        case htmlURL
        case description, implementation, permissions, conditions, limitations, body, featured
    }
}
