//
//  SpaceLocation.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-05-02.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import MapKit

struct SpaceLocation {
    private let latitude: Double
    private let longitude: Double
    
    init(latitude: Double,
         longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var spaceAnnotation: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                       longitude: longitude)
        return annotation
    }
}
