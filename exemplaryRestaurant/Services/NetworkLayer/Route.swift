//
//  Route.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import URITemplate

protocol Route {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var apiKey: String { get }
}

enum ExemplaryRestaurantRoute: Route {
    case crtfcUpsoInfo
    
    var scheme: String {
        return "http:"
    }
    
    var baseURL: String {
        return "//openapi.seoul.go.kr:8088/"
    }
    
    var apiKey: String {
        let filePath = Bundle.main.path(forResource: "APIKey", ofType: "plist")
        let resource = NSDictionary(contentsOfFile: filePath ?? "")
        guard let key = resource?["key"] as? String else { fatalError("API Key를 설정해주세요") }
        return key
    }
    
    var path: String {
        switch self {
        case .crtfcUpsoInfo:
            return "/json/CrtfcUpsoInfo"
        }
    }
}
