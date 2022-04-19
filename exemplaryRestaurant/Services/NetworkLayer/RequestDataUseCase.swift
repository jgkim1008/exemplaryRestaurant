//
//  NetworkModule.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import RxSwift

protocol RequestDataUseCase {
    func download<T: Decodable>(with route: Route, start: String, end: String)-> Observable<T>
}

final class DefaultRequestDataUseCase: RequestDataUseCase {
    private let generateURLUseCase: GenerateURLUseCase

    init(generateURLUseCase: GenerateURLUseCase = DefaultGenerateURLUseCase()) {
        self.generateURLUseCase = generateURLUseCase
    }
    
    func download<T: Decodable>(with route: Route, start: String, end: String) -> Observable<T> {
        let url = generateURLUseCase.makeURL(route: route, start: start, end: end)
        return Observable.create { emitter in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    emitter.onError(error)
                    return
                }
                
                if let data = data, let result = try? JSONDecoder().decode(T.self, from: data) {
                    emitter.onNext(result)
                }
                
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

