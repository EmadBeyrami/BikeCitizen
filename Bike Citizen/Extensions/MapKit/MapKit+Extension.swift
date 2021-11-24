//
//  MapKit+Extension.swift
//  Bike Citizen
//
//  Created by Emad Bayramy on 11/24/21.
//

import MapKit

extension MKMapView {
    func showLocation(location: CLLocationCoordinate2D, zoomDimension: CLLocationDistance = 120, animated: Bool = true) {
        setAnnotation(location: location)
        //Center the map on the place location
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: zoomDimension, longitudinalMeters: zoomDimension)
        self.setRegion(viewRegion, animated: true)
    }
    
    private func setAnnotation(location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.addAnnotation(annotation)
    }
}
