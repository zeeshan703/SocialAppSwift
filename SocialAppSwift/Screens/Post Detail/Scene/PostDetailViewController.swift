//
//  PostDetailViewController.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit
import GrowingTextView

class PostDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: GrowingTextView!
    
    var viewModel: PostDetailViewModel = PostDetailViewModel()
    var postVM: PostTableCellViewModel?
    var commentsVM: [PostCommentViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func sendTapped() {
        if let postVM {
            self.view.endEditing(true)
            viewModel.addNewCommentRequest(postId: postVM.postId, message: messageTextView.text)
        }
    }

}

// MARK: - Private/fileprivate methods
extension PostDetailViewController {
    fileprivate func configureView() {
        self.title = "Comments"
        setupTableView()
        bindViewModel()
        if let postVM, postVM.commentCount > 0 {
            viewModel.fetchComments(postId: postVM.postId) // fetch comment list
        }
    }
    
    fileprivate func bindViewModel() {
        observeEventsState() // to observe states of the api call
        observeCommentsList() // to observe the list of comments, when fetched from api
    }
    
    fileprivate func observeEventsState() {
        viewModel.eventHandler.bind { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                animateLoading(shouldShow: true)
            case .stopLoading:
                animateLoading(shouldShow: false)
            case .dataLoaded:
                messageTextView.text = ""
                animateLoading(shouldShow: false)
                reloadTableView()
            case .error(let error):
                animateLoading(shouldShow: false)
                self.showAlert(title: "Error!", message: error?.localizedDescription ?? "")
            default: break
            }
        }
    }
    
    fileprivate func observeCommentsList() {
        viewModel.comments.bind { [weak self] postsVM in
            guard let self, let postsVM = postsVM else {
                return
            }
            self.commentsVM = postsVM
            self.reloadTableView()
        }
    }
    
}
