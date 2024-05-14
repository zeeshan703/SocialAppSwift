//
//  AddNewPostViewController.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 14/05/2024.
//

import UIKit
import GrowingTextView

protocol AddNewPostViewControllerProtocol: NSObjectProtocol {
    func passDataToPostsList(post: PostModel)
}

class AddNewPostViewController: UIViewController {
    
    @IBOutlet weak var titleTextView: GrowingTextView!
    @IBOutlet weak var descriptionTextView: GrowingTextView!
    
    var viewModel: AddNewPostViewModel = AddNewPostViewModel()
    weak var delegate: AddNewPostViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    
    @IBAction func addNewTapped() {
        
        if let title = titleTextView.text, title.isEmpty {
            showAlert(title: "Alert!", message: "Please add post title.")
            return
        }
        
        if let description = descriptionTextView.text, description.isEmpty {
            showAlert(title: "Alert!", message: "Please add post description.")
            return
        }
        
        self.view.endEditing(true)
        viewModel.createNewPost(title: titleTextView.text, description: descriptionTextView.text)
    }

}


// MARK: - Private/fileprivate methods
extension AddNewPostViewController {
    fileprivate func bindViewModel() {
        observeEventsState() // to observe states of the api call
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
                if let post = viewModel.post {
                    delegate?.passDataToPostsList(post: post)
                    viewModel.post = nil
                    viewModel.eventHandler = Observable(nil)
                }
                self.navigationController?.popViewController(animated: true)
            case .error(let error):
                animateLoading(shouldShow: false)
                self.showAlert(title: "Error!", message: error?.localizedDescription ?? "")
            default: break
            }
        }
    }
}
