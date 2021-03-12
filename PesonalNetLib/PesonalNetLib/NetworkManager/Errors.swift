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
    case wrongUrl
    case noResponse
    case noData
    case networkError(Error)
}
