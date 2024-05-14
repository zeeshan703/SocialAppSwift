//
//  PostTableViewCell.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

protocol PostTableViewCellProtocol: NSObjectProtocol {
    func updateLike(cell: PostTableViewCell)
    func moveToComments(cell: PostTableViewCell)
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    
    weak var delegate: PostTableViewCellProtocol?
    
    @IBAction func likeTapped() {
        delegate?.updateLike(cell: self)
    }
    
    @IBAction func commentTapped() {
        delegate?.moveToComments(cell: self)
    }
    
    func setContent(_ data: Any) {
        guard let viewModel = data as? PostTableCellViewModel else  { return }
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.body
        likesCountLabel.text = "\(viewModel.likeCount)"
        commentsCountLabel.text = "\(viewModel.commentCount) Comments"
        updateLikeState(isLiked: viewModel.isLiked)
        if let user = viewModel.user {
            profileImageView.makeProfileImage(user.profileImageURL ?? "")
            nameLabel.text = user.name
        }
    }
    
    private func updateLikeState(isLiked: Bool) {
        likeImageView.tintColor = isLiked ? .link : .lightGray
        likeLabel.textColor = isLiked ? .link : .lightGray
    }
    
}
