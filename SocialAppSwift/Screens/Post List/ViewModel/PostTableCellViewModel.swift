//
//  PostTableCellViewModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation

class PostTableCellViewModel {
    var postId: Int
    var title: String
    var body: String
    var likeCount: Int
    var commentCount: Int
    var isLiked: Bool
    var user: User?
    
    init(post: PostModel) {
        self.postId = post.postId ?? 0
        self.title = post.title ?? ""
        self.body = post.body ?? ""
        self.likeCount = post.likeCount ?? 0
        self.commentCount = post.commentCount ?? 0
        self.isLiked = post.isLiked ?? false
        self.user = post.user ?? User()
    }
    
}
