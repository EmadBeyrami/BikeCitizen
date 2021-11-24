//
//  AppCoordinator.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

class AppCoordinator: NSObject, MainAppCoordinator {
    
    
    let window: UIWindow?
        
    // Since AppCoordinator is top of all coordinators of our app, it has no parent and is nil.
    weak var parentCoordinator: Coordinator?
    
    // ChildCoordinators of AppCoordinator
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabCoordinator: HomeTabBarViewController?
    
    init(navigationController: UINavigationController, window: UIWindow?) {
        self.navigationController = navigationController
        self.window = window
        super.init()
        navigationController.delegate = self
    }
    
    // Start of the app
    func start(animated: Bool) {
        guard let window = window else { return }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let flowControllerVC = FlowControlViewController.instantiate(coordinator: self)
        navigationController.pushViewController(flowControllerVC, animated: true)
        
    }
    
    // To Home scene
    func toProducts() {
        self.tabCoordinator = HomeTabBarViewController.instantiate(coordinator: self)
        
        guard let tabCoordinator = tabCoordinator else { return }
        
        let homeNavigation = UINavigationController()
        let homeScene = SearchCoordinator(navigationController: homeNavigation)
        homeScene.parentCoordinator = self
        childCoordinators.append(homeScene)
        homeScene.start()
        
//        let lotteriesNavigation = UINavigationController()
//        let lotteriesScene = LotteriesCoordinator(navigationController: lotteriesNavigation)
//        lotteriesScene.parentCoordinator = self
//        childCoordinators?.append(lotteriesScene)
//        lotteriesScene.start()
        
        tabCoordinator.setViewControllers([homeNavigation], animated: true)
        self.navigationController = homeNavigation
        window?.rootViewController = tabCoordinator
    }
    
    // We need to reset app when User changed app's language.
    func userChangedLanguage() {
        self.reloadApplication()
    }
    
    // Resetting and removing all childcoordinators of AppCoordinator
    private func reloadApplication() {
        self.childCoordinators.forEach {$0.navigationController.popToRootViewController(animated: false)}
        
        self.childCoordinators.removeAll()
        
        window?.rootViewController?.dismiss(animated: false, completion: nil)
        
        self.start()
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a products view controller
//        if let productsViewController = fromViewController as? ProductsViewController {
//            childDidFinish(productsViewController.coordinator)
//        }
    }
}
