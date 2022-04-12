//
//  RestaurantMKAnnotation.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/06.
//

import MapKit
import Foundation

final class RestaurantMKAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let locationName: String?
    let type: String?
    let coordinate: CLLocationCoordinate2D
    let phoneNumber: String?
    
    
    init(title: String?, subtitle: String?, locationName: String?, type: String?, coordinate: CLLocationCoordinate2D, phoneNumber: String?) {
        self.title = title
        self.subtitle = subtitle
        self.locationName = locationName
        self.type = type
        self.coordinate = coordinate
        self.phoneNumber = phoneNumber
    }
}
