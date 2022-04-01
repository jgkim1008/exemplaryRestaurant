//
//  File.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import RxSwift

protocol DataRequsetable {
    func download<T: Decodable>(url: URL) -> Observable<T>
}

protocol LocationTrackable {
    
}

protocol URLBuildable {
    func makeURL(route: Route, start: String, end: String) -> URL

}


final class UseCase {
    private let dataRequsetService: DataRequsetable
    private let urlRequestBuilder: URLBuildable
    
    init(dataRequsetService: DataRequsetable = NetworkModule(), urlRequestBuilder: URLRequsetBuilder = URLRequsetBuilder()) {
        self.dataRequsetService = dataRequsetService
        self.urlRequestBuilder = urlRequestBuilder
    }
    
    func fetchData<T: Decodable>(with route: Route, start: String, end: String) -> Observable<T> {
        let url = urlRequestBuilder.makeURL(route: route, start: start, end: end)
        return dataRequsetService.download(url: url)
    }
    
}
