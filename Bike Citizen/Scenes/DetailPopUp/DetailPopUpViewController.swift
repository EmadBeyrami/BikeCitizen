//
//  DetailPopUpViewController.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import UIKit
import MapKit

class DetailPopUpViewController: UIViewController, Storyboarded {
    
    weak var coordinator: Coordinator?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var model: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillView()
    }
    
    private func fillView() {
        if let lat = model?.lat, let long = model?.lon {
            setupMap(for: CLLocationCoordinate2D(latitude: lat, longitude: long))
        }
        
        if let url = URL(string: model?.iconURL ?? "") {
            imageView.load(url: url)
        }
        
        titleLabel.text = model?.name
        subtitleLabel.text = model?.summary
        
    }
    
    private func setupMap(for location: CLLocationCoordinate2D) {
        mapView.showLocation(location: location)
    }
}
