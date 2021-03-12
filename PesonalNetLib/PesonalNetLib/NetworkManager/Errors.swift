//
//  Errors.swift
//  PesonalNetLib
//
//  Created by 1 on 12.03.2021.
//

import Foundation

enum NetworkError: Error {
    
    case emptyRequest
    case emptyUrl
    case emptyHttpMethod
    case networkError(Error)
    case wrongUrl
    case noResponse
}
