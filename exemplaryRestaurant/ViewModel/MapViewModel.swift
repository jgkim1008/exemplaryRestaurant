//
//  MapViewModel.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/06.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay
import RxMKMapView
import MapKit

final class MapViewModel {
    private let useCase = UseCase()
    var restaurantObservable = BehaviorRelay<[RestaurantMKAnnotation]>(value: []) 
    var currentLocationObservable = BehaviorRelay<MKCoordinateRegion>(value: MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 37.496710550965,
                                                                                                                           longitude: 126.92542846895),
                                                                                                latitudinalMeters: 1000, longitudinalMeters: 1000))
    var mapViewModelDisposeBag = DisposeBag()
    
    init() {
        fetchingData()
    }
    
    func touchUPCurrentButton() {
        _ = useCase.getPermission()
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.useCase.getCurrentLocation()
                    .map { MKCoordinateRegion(center: $0, latitudinalMeters: 100, longitudinalMeters: 100)}
                    .bind(to:weakSelf.currentLocationObservable)
                    .disposed(by: weakSelf.mapViewModelDisposeBag)
            })
    }
    
    func defaultLocation() {
        _ = useCase.getCurrentLocation()
            .map { MKCoordinateRegion(center: $0, latitudinalMeters: 100, longitudinalMeters: 100)}
            .bind(to: currentLocationObservable)
            .disposed(by: mapViewModelDisposeBag)
    }
    
    func fetchingData() {
        let route = ExemplaryRestaurantRoute.crtfcUpsoInfo

        let firstData = useCase.fetchData(with: route, start: "1", end: "999")
            .map { (data: Restaurant)  -> [RestaurantMKAnnotation] in
                data.info.detail.map {
                    let coordinate = CLLocationCoordinate2D(latitude: Double($0.latitude) ?? .zero, longitude: Double($0.longitude) ?? .zero)
                    let title = $0.upsoNm
                    let locationName = $0.rdnCodeNm
                    let type = $0.cobCodeNm
                    let subtitle = $0.foodMenu
                    return RestaurantMKAnnotation(title: title, subtitle: subtitle, locationName: locationName, type: type, coordinate: coordinate)
                }
            }

        let secondData = useCase.fetchData(with: route, start: "1000", end: "1999")
            .map { (data: Restaurant) -> [RestaurantMKAnnotation] in
                data.info.detail.map {
                    let coordinate = CLLocationCoordinate2D(latitude: Double($0.latitude) ?? .zero, longitude: Double($0.longitude) ?? .zero)
                    let title = $0.upsoNm
                    let locationName = $0.rdnCodeNm
                    let type = $0.cobCodeNm
                    let subtitle = $0.foodMenu
                    return RestaurantMKAnnotation(title: title, subtitle: subtitle, locationName: locationName, type: type, coordinate: coordinate)
                }
            }
        
        let megeData = Observable.zip(firstData, secondData, resultSelector: { (first, second) in
            return first + second
        })
        .bind(to: restaurantObservable)
        .disposed(by: mapViewModelDisposeBag)
    }
    
    
}
