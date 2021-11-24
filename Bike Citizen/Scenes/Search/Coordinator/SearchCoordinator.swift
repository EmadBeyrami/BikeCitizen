//
//  SearchCoordinator.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var rootViewController: UIViewController?
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        let categoriesViewController = SearchViewController.instantiate(coordinator: self)
        navigationController.pushViewController(categoriesViewController, animated: animated)
    }
    
    func popUpDetail(model: SearchModel) {
//        let flowControllerVC = FlowControlViewController.instantiate(coordinator: self)
//        navigationController.pushViewController(flowControllerVC, animated: true)
        
        
        let detailViewController = DetailPopUpViewController.instantiate()
        detailViewController.model = model
            let nav = UINavigationController(rootViewController: detailViewController)
            nav.modalPresentationStyle = .pageSheet
            if let sheet = nav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
            }
        navigationController.present(nav, animated: true, completion: nil)
    }
    
    deinit {
        print("Removed \(self) from memory")
    }
}
