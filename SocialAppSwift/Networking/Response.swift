//
//  Response.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation

// MARK: Response type handling
public typealias JSON = [String: Any]
public typealias JSONArray = [JSON]

// Response Handler
//typealias RESPONSE_HANDLER = (JSON) -> ()

enum APIResponse<T> {
    case success(T)
    case failure(AppError)
}

enum Event {
    case loading
    case stopLoading
    case dataLoaded
    case error(AppError?)
}
