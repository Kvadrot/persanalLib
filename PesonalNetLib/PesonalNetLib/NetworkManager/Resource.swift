//
//  Resource.swift
//  PesonalNetLib
//
//  Created by 1 on 12.03.2021.
//

import Foundation

class ResourceObject {
    
    var urlComponents = URLComponents()
    var request: URLRequest?
    var body: Data?
    var headers =  [String : String]()
    
    init(requestMethod: HttpMethod,
         requestScheme: String,
         requestHost: String,
         requestPath: String,
         requestQueryItemes: [String: String]?) {
        
        self.request?.httpMethod = requestMethod.rawValue
        self.urlComponents.scheme = requestScheme
        self.urlComponents.host = requestHost
        self.urlComponents.path = requestPath
        
        guard let notEmpty = requestQueryItemes else {
            self.request = URLRequest(url: urlComponents.url!)
            return
        }
        setQueryItems(with: notEmpty)
        self.request = URLRequest(url: urlComponents.url!)
    }
    
    
    func setQueryItems(with parameters: [String : String]) {
        
        self.urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
//MARK: - set resource headers
//        func setHeaders(with headers: [String : String]) {
//
//            let allHeaders = headers.merging(headers, uniquingKeysWith: { (defaultKey, perRequestKey) in
//                return perRequestKey
//            })
//            self.request?.allHTTPHeaderFields = allHeaders
//        }
    
        func setHeaders(_ headers: [String : String]) {

            self.request?.allHTTPHeaderFields = headers
        }
}
