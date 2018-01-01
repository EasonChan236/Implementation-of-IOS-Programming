//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by EasonChan on 12/22/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var mapView: MKMapView!
    
    
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0 :
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .standard
        }
        
    }
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        
        
        //let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        
        let segmentedControl = UISegmentedControl(items: [standardString,satelliteString,hybridString])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant : 8)
        //let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .black
        button.setTitle("Locate", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MapViewController loaded its view")
        
    }
    func buttonAction(sender: UIButton!) {
        print("updateUserLocation is clicked")
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let zoomedInCurrentLocation = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500)
        mapView.setRegion(zoomedInCurrentLocation, animated: true)
    }

}
