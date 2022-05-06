//
//  APIBeerEndpoint.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

enum APIBeerEndpoint: Endpoint {
    
    case getBeerList(Int)
    
    var path: String {
        switch self {
        case .getBeerList:
            return "/v2/beers"
        }
    }
    
    var method: HTTPMethods {
        switch self {
        case .getBeerList:
            return .get
        }
    }
    
    func asURLRequest(baseURL: String) throws -> URLRequest {
        switch self {
        case .getBeerList(let page):
            let url = URL(string: baseURL)!
            var request = URLRequest(url: url.appendingPathComponent(self.path))
            request.httpMethod = self.method.rawValue.uppercased()
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            if page > 0 {
                request.appendGETParameters([["page": page]])
            }
            return request
        }
    }
    
    
}
