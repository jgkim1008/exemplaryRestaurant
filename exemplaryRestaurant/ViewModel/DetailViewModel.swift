//
//  DetailViewModel.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//

import Foundation
import MapKit
import RxSwift
import RxRelay

final class DetailViewModel {
    var restaurant: MKAnnotation
    var convertData: RestaurantMKAnnotation?
    
    init(restaurant: MKAnnotation) {
        self.restaurant = restaurant
        self.convertData = restaurant as? RestaurantMKAnnotation        
    }
    
    lazy var phoneNumber = convertData?.phoneNumber
    lazy var title = convertData?.title
    lazy var type = convertData?.type
    lazy var locationName = convertData?.locationName
    lazy var foodMenu = convertData?.subtitle
}
