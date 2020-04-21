//
//  ApiService.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 16.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Alamofire

class ApiService {
    private func baseRequest<T>(ofType: T.Type, url: String, method: HTTPMethod, params: Parameters? = nil,
                                completion: @escaping (Swift.Result<T, Error>) -> Void) where T: Decodable {
        AF.request(url, method: method, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(Swift.Result.success(decodedData))
                } catch let error {
                    completion(Swift.Result.failure(error))
                }
            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }
    
    func getRecipesList(completion: @escaping (Swift.Result<Response, Error>) -> Void) {
        baseRequest(ofType: Response.self, url: Constants.url, method: .get) { response in
            completion(response)
        }
    }
}
