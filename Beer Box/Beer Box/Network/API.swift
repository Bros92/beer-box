//
//  API.swift
//  Beer Box
//
//  Created by Vincenzo Broscritto on 05/05/22.
//

import Foundation

/// The HTTP methods for api request
enum HTTPMethods: String {
    case get
    case post
    case delete
    case put
}

protocol Endpoint {
    /// The path of api url
    var path: String { get }
    /// The HTTP method for the request
    var method: HTTPMethods { get }
    /// Create the request with header and body parameters
    /// - Returns: The api url request
    func asURLRequest(baseURL: String) throws -> URLRequest
}

/// Indicate the kind of error during api request
enum APIError: Error {
    case decodingError
    case genericError(Error?)
    case remoteError(APIResponseError)
    case unknownUrl
}

struct API {
    /// The base url of API
    private var baseUrl: String
    
    func makeRequest<T: Codable>(
        _ type: T.Type,
        at endpoint: Endpoint,
        with decoder: JSONDecoder = JSONDecoder(),
        completionHandler: @escaping (_ result: Result<T, APIError>) -> Void) {
            
        // Convert APIEndpoint to an URLRequest
        do {
            let request = try endpoint.asURLRequest(baseURL: self.baseUrl)
            URLSession.shared.dataTask(with: request) { response, _, error in
                if let error = error {
                    completionHandler(.failure(.genericError(error)))
                }
                guard let fileData = response else {
                    completionHandler(.failure(.unknownUrl))
                    return
                }
                // try to decode the response with api with the generic object
                if let successResponse = try? JSONDecoder().decode(T.self, from: fileData) {
                    completionHandler(.success(successResponse))
                    // Try to decode the response with github error structure
                } else if let failedResponse = try? JSONDecoder().decode(APIResponseError.self, from: fileData) {
                    completionHandler(.failure(.remoteError(failedResponse)))
                } else {
                    // Handle a generic error
                    completionHandler(.failure(.genericError(error)))
                }
            }
            .resume()
        } catch {
            completionHandler(.failure(.genericError(error)))
        }
    }
}

extension API {
    static let dev = API(baseUrl: "https://api.punkapi.com")
    static var api: API {
        #if DEBUG
        return API.dev
        #else
        // There isn't a different base url for production
        return API.dev
        #endif
    }
}
