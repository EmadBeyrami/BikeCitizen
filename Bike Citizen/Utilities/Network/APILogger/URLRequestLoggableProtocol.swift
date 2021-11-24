//
//  URLRequestLoggableProtocol.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

protocol URLRequestLoggableProtocol {
    func logResponse(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}
