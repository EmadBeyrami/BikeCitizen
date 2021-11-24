//
//  Coordinator.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

protocol MainAppCoordinator: NSObject, Coordinator {
    var tabCoordinator: HomeTabBarViewController? { get set }
}

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func navigateTo(deepLink: DeepLink)
    func start(animated: Bool)
    func finish()
}

extension Coordinator {
    
    func start() {
        start(animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func navigateTo(deepLink: DeepLink) {}
    
    func finish() {}
}
