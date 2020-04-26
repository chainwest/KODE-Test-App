//
//  Repository.swift
//  KODE-Test-App
//
//  Created by Evgeniy on 25.04.2020.
//  Copyright © 2020 Evgeniy. All rights reserved.
//

import Foundation


class DataRepository {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func getRecipes(_ completion: @escaping (Swift.Result<[Recipe]?, Error>) -> Void) {
        apiService.getRecipesList { response in
            switch response {
            case .success(let data):
                completion(Swift.Result.success(data.recipes))
            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }
}

