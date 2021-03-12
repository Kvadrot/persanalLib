//
//  NetworkManager.swift
//  PesonalNetLib
//
//  Created by 1 on 04.03.2021.
//

import Foundation




class NetworkManager {
    
    func doNetwork<T: Decodable>(_ resourseObject: ResourceObject, _ dataType: T.Type, completion: @escaping (_ data: T?) -> Void) throws {

        guard let request = resourseObject.request else { throw NetworkError.emptyRequest }
        guard request.url != nil else { throw NetworkError.emptyUrl }
        guard request.httpMethod != nil else { throw NetworkError.emptyHttpMethod }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response else { return print("respGamno")}
            guard let data = data else { return print("DATAGamno")}
            guard error == nil else { return print("errorGamno")}
            
            let isValid: Bool = self.validateResponseStatusCode(response)
            
            guard isValid == true else { return print("isValid Gamno") }
            
            let result = self.decodeResponseData(dataForDecoding: data, dataType: dataType)
            completion(result)
            
        }
        task.resume()
        
    }
    
    func decodeResponseData<T: Decodable>(dataForDecoding: Data, dataType: T.Type) -> T? {

        do {
            let decoder = JSONDecoder()
            
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
