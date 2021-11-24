//
//  SearchModel.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

// MARK: - Array of SearchModel
typealias SearchArrayModel = [SearchModel]

// MARK: - SearchModel
struct SearchModel: Codable {
    let name, summary: String?
    let type: AddressType?
    let lat, lon: Double?
    let id: String?
    let iconURL: String?
    var isFavorite: Bool = false

    enum CodingKeys: String, CodingKey {
        case name, summary, type, lat, lon, id
        case iconURL = "icon_url"
    }
}

enum AddressType: String, Codable {
    case address = "address"
}
