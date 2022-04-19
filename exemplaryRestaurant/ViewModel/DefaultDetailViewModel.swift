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

protocol DetailViewModelInput { 
    func viewWillDisapper()
}

protocol DetailViewModelOutput {
    var restaurantMKAnnotation: RestaurantMKAnnotation? { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput { }

final class DefaultDetailViewModel: DetailViewModel {
    weak var coordinator: DetailViewCoordinator?
    private var restaurant: MKAnnotation
    var restaurantMKAnnotation: RestaurantMKAnnotation?

    init(restaurant: MKAnnotation) {
        self.restaurant = restaurant
        self.restaurantMKAnnotation = restaurant as? RestaurantMKAnnotation        
    }

    
    func viewWillDisapper() {
        coordinator?.viewWillDisapper()
    }
}
