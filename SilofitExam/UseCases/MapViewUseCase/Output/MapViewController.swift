//
//  MapViewController.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: NavigationContainer {
    private let mapView: MKMapView = MKMapView(frame: .zero)
    
    private let localLocation = CLLocationCoordinate2D(latitude: 45.5017, longitude: -73.5673)
    
    weak var input: Readyable?
    
    init(theme: Theme, navModel: NavigationBarModel) {
        let navigationFactory = NavigationConfigFactory(theme: theme)
        let navigationConfig = navigationFactory.getNavigationConfig(fromModel: navModel)
        super.init(navigationConfig: navigationConfig,
                   containerView: mapView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapRegion(usingLocation: localLocation)
        input?.isReady()
    }
    
    private func setMapRegion(usingLocation location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location,
                                        latitudinalMeters: 20000,
                                        longitudinalMeters: 20000)
        mapView.setRegion(region, animated: true)
    }
    
    private func displayLocations(locations: [SpaceLocation]) {
        let annotations = locations.map({ $0.spaceAnnotation })
        mapView.addAnnotations(annotations)        
    }
}

protocol MapViewOutput {
    func display(_ locations: [SpaceLocation])
}

extension MapViewController: MapViewOutput {
    func display(_ locations: [SpaceLocation]) {
        displayLocations(locations: locations)
    }
}
