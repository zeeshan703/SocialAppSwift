//
//  PostListViewController.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

class PostListViewController: UIViewController {

    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PostListViewModel = PostListViewModel()
    var postsVM: [PostTableCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func addTapped() {
        moveToAddNewScreen()
    }
}

// MARK: - Private/fileprivate methods
extension PostListViewController {
    func configureView() {
        // Add new post button configuration
        let addButton = UIBarButtonItem(title: "Add New", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton
        
        setupTableView()
        bindViewModel()
        viewModel.fetchPostList()
    }
    
    fileprivate func bindViewModel() {
        observeEventsState() // to observe states of the api call
        observePostsList() // to observe the list of posts, when fetched from api
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
                animateLoading(shouldShow: false)
                reloadTableView()
            case .error(let error):
                animateLoading(shouldShow: false)
                self.showAlert(title: "Error!", message: error?.localizedDescription ?? "")
            default: break
            }
        }
    }
    
    fileprivate func observePostsList() {
        viewModel.posts.bind { [weak self] postsVM in
            guard let self, let postsVM = postsVM else {
                return
            }
            self.postsVM = postsVM
            self.reloadTableView()
        }
    }
    
    fileprivate func moveToAddNewScreen() {
        let destVC = AddNewPostViewController.load(from: .main)
        destVC.delegate = self
        self.navigationController?.pushViewController(destVC, animated: false)
    }
}

// MARK: - PostTableViewCellProtocol
extension PostListViewController: PostTableViewCellProtocol {
    func updateLike(cell: PostTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            viewModel.updatePostLike(id: indexPath.row)
        }
    }
    
    func moveToComments(cell: PostTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let destVC = PostDetailViewController.load(from: .main)
            destVC.postVM = postsVM[indexPath.row]
            self.navigationController?.pushViewController(destVC, animated: false)
        }
    }
}


// MARK: - AddNewPostViewControllerProtocol
extension PostListViewController: AddNewPostViewControllerProtocol {
    func passDataToPostsList(post: PostModel) {
        viewModel.insertNewPostAndRefresh(post: post)
    }
}
