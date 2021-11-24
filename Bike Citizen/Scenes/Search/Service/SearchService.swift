//
//  SearchService.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

/*

 This is Search Service, responsible for making api calls of getting Search Result.
 
 */

typealias SearchCompletionHandler = (Result<RequestCallback<SearchArrayModel>, RequestError>) -> Void

protocol SearchServiceProtocol {
    func searchFor(place: String, completionHandler: @escaping SearchCompletionHandler)
}

/*
 SearchEndpoint is URLPath of Product Api calls
 */

private enum SearchEndpoint {
    case search(String)
    
    var path: String {
        switch self {
        case .search(let place):
            return "search?q=\(place)"
        }
    }
}

class ProductService: SearchServiceProtocol {
    
    private let requestManager: RequestManagerProtocol
    
    public static let shared: SearchServiceProtocol = ProductService(requestManager: RequestManager.shared)
    
    // We can also inject requestManager for testing purposes.
    init(requestManager: RequestManagerProtocol) {
        self.requestManager = requestManager
    }
    
    func searchFor(place: String, completionHandler: @escaping SearchCompletionHandler) {
        let querifiedPlace = place.querify() ?? ""
        self.requestManager.performRequestWith(url: SearchEndpoint.search(querifiedPlace).path, httpMethod: .get) { (result: Result<RequestCallback<SearchArrayModel>, RequestError>) in
            // Taking Data to main thread so we can update UI.
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
    }
    
}

