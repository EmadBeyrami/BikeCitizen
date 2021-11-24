//
//  UIColor+Extensions.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

extension UIColor {
    
    private enum CustomColor: String {
        
        case zalandoOrange
        case BlackWhite
        
        var color: UIColor {
            guard let color = UIColor(named: rawValue) else {
                assertionFailure("Color missing from asset catalogue")
                return .systemOrange
            }
            return color
        }
    }
    
    static var zalandoOrange: UIColor = {
        CustomColor.zalandoOrange.color
    }()
    
    static var blackWhite: UIColor = {
        CustomColor.BlackWhite.color
    }()
}
