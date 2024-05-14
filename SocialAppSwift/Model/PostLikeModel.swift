//
//  PostLikeModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 14/05/2024.
//

import Foundation

class PostLikeModel: NSObject, Codable {
    var status: Bool?
    var message: String?
    
    private enum CodingKeys: String, CodingKey {
        case status, message
    }
}
