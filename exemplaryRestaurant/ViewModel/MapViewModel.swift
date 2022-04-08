//
//  MapViewModel.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/06.
//

import Foundation
import CoreLocation
import RxRelay

final class MapViewModel {
    private let useCase = UseCase()
    var restaurantObservable = BehaviorRelay<[RestaurantMKAnnotation]>(value: []) 

    
    init() {
        fetchingData()
    }
    
    func touchUPCurrentButton() {
        useCase.getPermission()
            .subscribe(onNext: { [weak self] _ in
                self?.useCase.getCurrentLocation()
            })
    }
    
    func fetchingData() {
        let route = ExemplaryRestaurantRoute.crtfcUpsoInfo
        useCase.fetchData(with: route, start: "1", end: "999")
            .map { (data: Restaurant) in
                data.info.detail.map {
                    let coordinate = CLLocationCoordinate2D(latitude: Double($0.latitude) ?? .zero, longitude: Double($0.longitude) ?? .zero)
                    let title = $0.upsoNm
                    let locationName = $0.rdnCodeNm
                    let type = $0.cobCodeNm
                    let subtitle = $0.foodMenu
                    print(title, coordinate, locationName, type,subtitle)
                    return RestaurantMKAnnotation(title: title, subtitle: subtitle, locationName: locationName, type: type, coordinate: coordinate)
                }
            }
            .take(1)
            .bind(to: restaurantObservable)
    }
    
    
}
