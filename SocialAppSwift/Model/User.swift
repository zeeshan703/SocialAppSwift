//
//  User.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

class User: NSObject, Codable {
    var userId: Int?
    var name: String?
    var profileImageURL: String?
    
    override init() {
    }
    
    init(userId: Int? = nil, name: String? = nil, profileImageURL: String? = nil) {
        self.userId = userId
        self.name = name
        self.profileImageURL = profileImageURL
    }
    
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case profileImageURL = "profile_image_url"
    }
}
