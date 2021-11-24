//
//  BikeCitizenTableViewCell.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit

public protocol BikeCitizenTableViewCell: UITableViewCell {
    
    associatedtype CellViewModel
    
    func configureCellWith(_ item: CellViewModel)
    
}
