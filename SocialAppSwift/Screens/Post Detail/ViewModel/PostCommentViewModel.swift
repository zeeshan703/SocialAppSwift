//
//  PostCommentViewModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

class PostCommentViewModel {
    var user: User?
    var comment: String
    
    init(comment: PostModel) {
        self.comment = comment.comment ?? ""
        self.user = comment.user ?? User()
    }
    
}
