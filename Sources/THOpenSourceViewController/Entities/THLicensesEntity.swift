//
//  File.swift
//  
//
//  Created by 유태훈 on 2023/10/05.
//

import Foundation

struct THLicensesEntity: Codable {
    var key: THLicensesKey
    var name: String
    var spdxID: String
    var url: String
    var nodeID: String

    enum CodingKeys: String, CodingKey {
        case key
        case name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}
