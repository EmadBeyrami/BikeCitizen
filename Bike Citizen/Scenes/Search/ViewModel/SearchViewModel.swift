//
//  SearchViewModel.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import Foundation

final class SearchViewModel {
    
    var searchService: SearchServiceProtocol
    
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }
    
    var loading: DataCompletion<Bool>?
    
    var products: DataCompletion<SearchArrayModel>?
    var errorHandler: DataCompletion<String>?
    
    var allProducts: SearchArrayModel = []
    
    private var productsCache: RequestCallback<SearchArrayModel>?
    
    func search(for place: String) {
        searchService.searchFor(place: place) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                guard let searchData = products.data else {
                    assertionFailure("No Data")
                    return
                }
                self.allProducts = searchData
                self.productsCache = products
                self.checkForFavourites()
            case .failure(let error):
                self.errorHandler?(error.localizedDescription)
            }
        }
    }
    
    func setFavorite(id: String) {
        if let itemIndex = allProducts.firstIndex(where: {$0.id == id}) {
            allProducts[itemIndex].isFavorite = !allProducts[itemIndex].isFavorite
            saveItem(model: allProducts[itemIndex], isFaved: allProducts[itemIndex].isFavorite)
        }
    }
    
    private func saveItem(model: SearchModel, isFaved: Bool) {
        guard let id = model.id else { return }
        
        if isFaved {
            UserDefaultsConfig.favList.append(id)
        } else {
            UserDefaultsConfig.favList.removeAll(where: {$0 == model.id})
        }
    }
    
    private func checkForFavourites() {
        for (i, model) in allProducts.enumerated() {
            if UserDefaultsConfig.favList.first(where: { $0 == model.id }) != nil {
                allProducts[i].isFavorite = true
            }
        }
        self.products?(allProducts)
    }
}
