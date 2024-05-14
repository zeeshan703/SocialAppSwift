//
//  UtilityMethods.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation
import Alamofire

class UtilityMethods {
    func printQueryParameters(request: URLRequest, params: Parameters) -> String {
        do {
            let request = try URLEncoding.queryString.encode(request, with: params)
            if let url = request.url {
                return "Query string: \"\(url.absoluteURL)\""
            } else {
                return "Query string not available"
            }
        } catch {
            return "Query string error:\(error.localizedDescription)"
        }
    }
}
