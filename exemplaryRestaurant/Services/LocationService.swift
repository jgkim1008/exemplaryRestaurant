//
//  LocationService.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/01.
//

import Foundation
import RxSwift
import RxCoreLocation
import CoreLocation

final class LocationService: NSObject, LocationTrackable {
    private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        return manager
    }()
    
    private var location = BehaviorSubject<CLLocationCoordinate2D>(value: .init(latitude: 37.5283169, longitude: 126.9294254))
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        
        self.locationManager.rx.didUpdateLocations
            .compactMap { $0.locations.last?.coordinate}
            .bind(onNext: location.onNext(_:))
            .disposed(by: disposeBag)
    }
    
    func requestPermission()-> Observable<CLAuthorizationStatus> {
        locationManager.requestWhenInUseAuthorization()
        return Observable.deferred { [weak self] in
            guard let weakSelf = self else { return .empty()}
            weakSelf.locationManager.requestWhenInUseAuthorization()
            return weakSelf.locationManager.rx.didChangeAuthorization
                .map { $1 }
                .filter { $0 != .notDetermined}
                .do(onNext: { _ in
                    weakSelf.locationManager.startUpdatingLocation()
                })
                .take(1)
        } 
    }
    
    func requestLocation() -> BehaviorSubject<CLLocationCoordinate2D> {
        return location
    }
    
}

