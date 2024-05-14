//
//  PostEndPoints.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation
import Alamofire

enum PostEndPoints: APIConfiguration {
    case fetchPosts
    case fetchComments(postId: Int)
    case addNewComment(postId: Int, message: String)
    case postLike
    case createPost(title: String, description: String)
    
    
    // MARK: HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .fetchPosts, .fetchComments:
            return .get
        default:
            return .post
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .fetchPosts:
            return "e8ec5762-1bc9-43fb-826e-7bfbc6147730"
        case .fetchComments:
            return "a6d8b26a-fc48-416a-8134-3d6332fb942e"
        case .postLike:
            return "/5ce40014-b8f0-40d0-89ab-e4652148795f"
        case .createPost, .addNewComment:
            return "/posts"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .createPost(let title, let description):
            return ["title": title, "body": description]
        case .addNewComment(let postId, let message):
            return ["comment": message, "post_id": postId]
        default:
            return [:]
        
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try Constant.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print("--------- Request --------")
                print("URL: \(url.appendingPathComponent(path))")
                print("Parmas: \(parameters)")
                print("Headers: \(urlRequest.headers)")
                print("Type: \(method.rawValue)")
                print(UtilityMethods().printQueryParameters(request: urlRequest, params: parameters))
                print("--------------------------")
                if method.rawValue != "GET" {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                    //                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } else {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
    // seperate for JSONPlaceholder
    func asURLRequestJsonPlaceholder() throws -> URLRequest {
        let url = try Constant.jsonPlaceholderBaseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        // Parameters
        if let parameters = parameters {
            do {
                print("--------- Request --------")
                print("URL: \(url.appendingPathComponent(path))")
                print("Parmas: \(parameters)")
                print("Headers: \(urlRequest.headers)")
                print("Type: \(method.rawValue)")
                print(UtilityMethods().printQueryParameters(request: urlRequest, params: parameters))
                print("--------------------------")
                if method.rawValue != "GET" {
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
                    //                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } else {
                    urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
