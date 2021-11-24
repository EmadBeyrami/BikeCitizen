//
//  RequestCallbackModel.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

// MARK: - Base RequestCallback model
struct RequestCallback<T: Codable>: Codable {
    let data: T?
}
