//
//  ResponseValidatorProtocol.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validation<T: Codable>(response: HTTPURLResponse?, data: Data?) -> Result<T, RequestError>
}
