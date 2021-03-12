//
//  NetworkManager.swift
//  PesonalNetLib
//
//  Created by 1 on 04.03.2021.
//

import Foundation




class NetworkManager {

    private let decoder = JSONDecoder()

    func doNetwork<T: Decodable>(_ resourseObject: ResourceObject, _ dataType: T.Type, completion: @escaping (Result<T?, Error>) -> Void) throws {

        guard let request = resourseObject.request else { throw NetworkError.emptyRequest }
        guard request.url != nil else { throw NetworkError.emptyUrl }
        guard request.httpMethod != nil else { throw NetworkError.emptyHttpMethod }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let response = response else {
                completion(.failure(NetworkError.noResponse))
                return }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return }
            
            guard error == nil else {
                completion(.failure(NetworkError.networkError(error!)))
                return }

            let isValid: Bool = self.validateResponseStatusCode(response)

            guard isValid == true else { return print("isValid Gamno") }

            let result = self.decodeResponseData(dataForDecoding: data, dataType: dataType)
            completion(.success(result))

        }
        task.resume()
    }

    func decodeResponseData<T: Decodable>(dataForDecoding: Data, dataType: T.Type) -> T? {

        do {

            let result = try decoder.decode(dataType.self, from: dataForDecoding)
            return result
        } catch {

            print(error)
            return nil
        }
    }
}

extension NetworkManager {

    func validateResponseStatusCode(_ responseStatusCode: URLResponse) -> Bool {

        let validCodes = 200..<299

        if validCodes ~= (responseStatusCode as? HTTPURLResponse)!.statusCode {

            return true

        } else {

            return false
        }
    }
}
