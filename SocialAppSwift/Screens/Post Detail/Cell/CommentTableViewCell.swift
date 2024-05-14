//
//  CommentTableViewCell.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    func setContent(_ data: Any) {
        guard let viewModel = data as? PostCommentViewModel else  { return }
        self.commentLabel.text = viewModel.comment
        if let user = viewModel.user {
            nameLabel.text = user.name
        }
    }
    
}
