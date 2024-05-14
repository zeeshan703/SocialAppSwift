//
//  APIManager.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation
import Alamofire

class APIManager {
    
    // MARK: Singleton Implementation
    static let sharedInstance = APIManager()
    private init() {}
    
    func makeRequet<T: Decodable>(request: URLRequest, dataReturnType: T.Type, completionHandler: @escaping (APIResponse<T>) -> Void) {
        
        AF.request(request)
            .validate(contentType: ["application/json", "text/html"])
            .responseData {(response) in
                switch response.result {
                case .success(let value):
                    do {
                        print("----- Json Response -----")
                        print(value.prettyPrintedJSONString ?? "")
                        print("-------------------------")
                        //po print(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue) ?? “”)
                        let result = try JSONDecoder().decode(T.self, from: value)
                        completionHandler(.success(result))
                        
                    } catch let error {
                        completionHandler(.failure(AppError.internalFailed(reason: error)))
                    }
                case .failure(let error):
                    completionHandler(.failure(AppError.internalFailed(reason: error)))
                }
            }
    }
}
