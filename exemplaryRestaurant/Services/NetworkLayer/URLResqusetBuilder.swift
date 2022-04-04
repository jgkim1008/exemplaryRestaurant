//
//  URLResqusetBuilder.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import Foundation
import URITemplate

struct URLRequsetBuilder: URLBuildable {
    func makeURL(route: Route, start: String, end: String) -> URL {
        let apikey = route.apiKey
        let template = URITemplate(template: "\(route.scheme)\(route.baseURL)\(apikey)\(route.path)/{start}/{end}")
        let urlString = template.expand(["start": start, "end": end])
        guard let url = URL(string: urlString) else { fatalError("URL을 확인해주세요")}
        return url
    }
}
