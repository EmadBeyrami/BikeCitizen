//
//  HomeTabbarViewController.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

final class HomeTabBarViewController: UITabBarController, UITabBarControllerDelegate, Storyboarded {
    
    weak var coordinator: Coordinator?
    
    @IBOutlet var strTabBar: UITabBar!
    var lastIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (self.tabBar.items ?? []).forEach({$0.title = ""})
        
        self.setValue(strTabBar, forKey: "tabBar")
        
        // strTabBar.tapDelegate = self
        self.delegate = self
        tabBar.tintColor = .clear
    }
    
    // MARK: - UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        (self.tabBar.items ?? []).forEach({$0.title = ""})
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            lastIndex = selectedIndex
        }
    }
    
    func switchTab(newIndex: Int) {
        (self.tabBar.items ?? []).forEach({$0.title = ""})
        self.selectedIndex = newIndex
    }
}

var screenWidth: CGFloat { return UIScreen.main.bounds.width }
