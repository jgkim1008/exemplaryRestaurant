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

protocol MapViewModelInput {
    func didSelect(_ restaurant: MKAnnotation?)
}

protocol MapViewModelOutput {
    var restaurantObservable: BehaviorRelay<[RestaurantMKAnnotation]> { get }
    var currentLocationObservable: BehaviorRelay<MKCoordinateRegion> { get }
}

protocol MapViewModel: MapViewModelInput, MapViewModelOutput { }

final class DefaultMapViewModel: MapViewModel {
    // MARK: - OUTPUT
    var restaurantObservable = BehaviorRelay<[RestaurantMKAnnotation]>(value: []) 
    var currentLocationObservable = BehaviorRelay<MKCoordinateRegion>(value: MKCoordinateRegion(center:CLLocationCoordinate2D(latitude: 37.496710550965,
                                                                                                                           longitude: 126.92542846895),
                                                                                                latitudinalMeters: 1000, longitudinalMeters: 1000))
    weak var coordinator: MainCoordinator?
    private let locationUseCase: LocationUseCase
    private let requestDataUseCase: RequestDataUseCase
    private var mapViewModelDisposeBag = DisposeBag()
    
    init(locationUseCase: LocationUseCase = DefaultLocationUseCase(), requestDataUseCase: RequestDataUseCase = DefaultRequestDataUseCase()) {
        self.locationUseCase = locationUseCase
        self.requestDataUseCase = requestDataUseCase
        fetchingData()
    }
    
    func touchUPCurrentButton() {
        _ = locationUseCase.requestPermission()
            .subscribe(onNext: { [weak self] _ in
                guard let weakSelf = self else { return }
                weakSelf.locationUseCase.requestLocation()
                    .map { MKCoordinateRegion(center: $0, latitudinalMeters: 100, longitudinalMeters: 100)}
                    .bind(to:weakSelf.currentLocationObservable)
                    .disposed(by: weakSelf.mapViewModelDisposeBag)
            })
    }
    
    func defaultLocation() {
        _ = locationUseCase.requestLocation()
            .map { MKCoordinateRegion(center: $0, latitudinalMeters: 100, longitudinalMeters: 100)}
            .bind(to: currentLocationObservable)
            .disposed(by: mapViewModelDisposeBag)
    }
    
    private func fetchingData() {
        let route = ExemplaryRestaurantRoute.crtfcUpsoInfo
        let firstData = requestDataUseCase.download(with: route, start: "1", end: "999")
            .map { (data: RestaurantResponseDTO) in
                data.toDomain(data)
            }
        
        let secondData = requestDataUseCase.download(with: route, start: "1000", end: "1999")
            .map { (data: RestaurantResponseDTO) in
                data.toDomain(data)
            }

        _ = Observable.zip(firstData, secondData, resultSelector: { (first, second) in
            return first + second
        })
        .bind(to: restaurantObservable)
        .disposed(by: mapViewModelDisposeBag)
    }
}

// MARK: - INPUT
extension DefaultMapViewModel {
    func didSelect(_ restaurant: MKAnnotation?) {
        coordinator?.pushDetailVC(restaurant)
    }
}
