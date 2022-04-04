//
//  File.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import RxSwift
import CoreLocation

protocol DataRequsetable {
    func download<T: Decodable>(url: URL) -> Observable<T>
}

protocol LocationTrackable {
    func requestPermission() -> Observable<CLAuthorizationStatus>
    func requestLocation() -> BehaviorSubject<CLLocationCoordinate2D>

}

protocol URLBuildable {
    func makeURL(route: Route, start: String, end: String) -> URL
}


final class UseCase {
    private let dataRequsetService: DataRequsetable
    private let urlRequestBuilder: URLBuildable
    private let locationService: LocationTrackable
    
    init(dataRequsetService: DataRequsetable = NetworkModule(),
         urlRequestBuilder: URLRequsetBuilder = URLRequsetBuilder(),
         locationService: LocationTrackable = LocationService()) {
        self.dataRequsetService = dataRequsetService
        self.urlRequestBuilder = urlRequestBuilder
        self.locationService =  locationService
    }
    
    func fetchData<T: Decodable>(with route: Route, start: String, end: String) -> Observable<T> {
        let url = urlRequestBuilder.makeURL(route: route, start: start, end: end)
        return dataRequsetService.download(url: url)
    }
        
    func getCurrentLocation() -> BehaviorSubject<CLLocationCoordinate2D> {
        return locationService.requestLocation()
    }
    
    func getPermission() -> Observable<CLAuthorizationStatus> {
        locationService.requestPermission()
    }
    
}
