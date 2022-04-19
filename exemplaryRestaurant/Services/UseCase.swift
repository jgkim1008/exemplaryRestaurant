//
//  File.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import RxSwift
import CoreLocation






// Adapter 패턴?
//final class UseCase {
//    private let dataRequsetService: RequestDataUseCase
//    private let urlRequestBuilder: GenerateURLUseCase
//    private let locationService: LocationUseCase
//    
//    init(dataRequsetService: RequestDataUseCase = DefaultRequestDataUseCase(),
//         urlRequestBuilder: DefaultGenerateURLUseCase = DefaultGenerateURLUseCase(),
//         locationService: LocationUseCase = DefaultLocationUseCase()) {
//        self.dataRequsetService = dataRequsetService
//        self.urlRequestBuilder = urlRequestBuilder
//        self.locationService =  locationService
//    }
//    
//    func fetchData<T: Decodable>(with route: Route, start: String, end: String) -> Observable<T> {
//        let url = urlRequestBuilder.makeURL(route: route, start: start, end: end)
//        return dataRequsetService.download(url: url)
//    }
//        
//    func getCurrentLocation() -> BehaviorSubject<CLLocationCoordinate2D> {
//        return locationService.requestLocation()
//    }
//    
//    func getPermission() -> Observable<CLAuthorizationStatus> {
//        locationService.requestPermission()
//    }
//    
//}
