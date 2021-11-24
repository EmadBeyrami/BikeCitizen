//
//  SearchViewController.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    @IBOutlet var productsTableView: UITableView!
    
    var productsTableViewDataSource: BikeCitizenTableViewDataSource<LocationTableViewCell>!
        
    weak var coordinator: SearchCoordinator?
    
    let productsViewModel = SearchViewModel(searchService: ProductService.shared)
    
    var dispatchWorkItem: DispatchWorkItem?
    
    private lazy var searchbar: UISearchController = {
        let search = UISearchController()
        search.searchBar.showsCancelButton = false
        search.searchBar.placeholder = LocalizedStrings.changeLanguage.value
        search.searchBar.sizeToFit()
        self.definesPresentationContext = true
        return search
    }()
    
    // MARK: - ViewCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
    }
    
    // MARK: - Customizing View
    private func setupView() {
        // Navigation Controller
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // productsTableViewDataSource
        productsTableViewDataSource = BikeCitizenTableViewDataSource(cellHeight: nil, items: [], tableView: productsTableView, delegate: self, animationType: .type1(0.5))
        productsTableView.delegate = productsTableViewDataSource
        productsTableView.dataSource = productsTableViewDataSource
        
        setupNavigationView()
    }
    
    private func setupNavigationView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        title = LocalizedStrings.toProducts.value
        navigationItem.searchController = searchbar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Bindings
    private func setupBindings() {
        
        // Subscribe to Loading
        productsViewModel.loading = { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.view.animateActivityIndicator() : self.view.removeActivityIndicator()
        }
        
        // Subscribe to Products
        productsViewModel.products = { [weak self] products in
            guard let self = self else { return }
            // Add new products to tableView dataSource.
            self.productsTableViewDataSource.refreshWithNewItems(products)
            print(self.productsTableViewDataSource.items)
        }
        
        // Subscribe to errors
        productsViewModel.errorHandler = { [weak self] error in
            guard let self = self else { return }
            let ac = UIAlertController(title: "Error",
                                        message: error,
                                        preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
        
        searchbar.searchBar.searchTextField.addTarget(self, action: #selector(searchTextDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func searchTextDidChange(_ searchbar: UITextField) {
        
        dispatchWorkItem?.cancel()
        
        guard let text = searchbar.text,
              !text.isEmpty,
              text.count > 2 else {
                  self.productsTableViewDataSource.refreshWithNewItems([])
                  return
              }
        
        let requestWorkItem = DispatchWorkItem { [unowned self] in
            self.search(place: text)
        }
        
        dispatchWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
    
    private func search(place: String) {
        productsViewModel.search(for: place)
    }
}

// MARK: - BikeCitizenTableViewDelegate
extension SearchViewController: BikeCitizenTableViewDelegate {
    
    func tableView<T>(didSelectModelAt model: T) {
        guard let model = model as? SearchModel else { return }
        self.coordinator?.popUpDetail(model: model)
    }
    
    func tableView(willDisplay cellIndexPath: IndexPath, cell: UITableViewCell) {
        guard let cell = cell as? LocationTableViewCell else { return }
        cell.bindFavButton { [weak self] id in
            guard let self = self else { return }
            self.productsViewModel.setFavorite(id: id)
            self.productsTableViewDataSource.refreshWithNewItems(self.productsViewModel.allProducts, animate: false)
        }
    }
}
