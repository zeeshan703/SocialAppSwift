//
//  PostModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

class PostModel: NSObject, Codable {
    var postId: Int?
    var title: String?
    var body: String?
    var likeCount: Int?
    var commentCount: Int?
    var isLiked: Bool?
    var comment: String?
    var user: User?
    
    private enum CodingKeys: String, CodingKey {
        case title, body, user, comment
        case postId = "post_id"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case isLiked = "is_liked"
    }
}
