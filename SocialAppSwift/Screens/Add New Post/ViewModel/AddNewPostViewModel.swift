//
//  AddNewPostViewModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 14/05/2024.
//

import UIKit

final class AddNewPostViewModel {
    
    var eventHandler: Observable<Event> = Observable(nil)
    var post: PostModel?    
    
    func createNewPost(title: String, description: String) {
        eventHandler.value = .loading
        let endPoint = PostEndPoints.createPost(title: title, description: description)
        do {
            let request = try endPoint.asURLRequestJsonPlaceholder()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: PostModel.self) { (response) in
                self.eventHandler.value = .stopLoading
                switch response {
                case .success(let data):
                    self.post = data
                    self.mapNewPost(title: self.post?.title ?? "", description: self.post?.body ?? "")
                    self.eventHandler.value = .dataLoaded
                case .failure(let error):
                    print("Error Occured: \(error)")
                    self.eventHandler.value = .error(error)
                }
            }
        } catch {
            self.eventHandler.value = .error(AppError.internalFailed(reason: error))
        }
    }
    
    func mapNewPost(title: String, description: String) {
        if let post {
            post.title = title
            post.body = description
            post.likeCount = 0
            post.commentCount = 0
            post.isLiked = false
            post.user = User(userId: 11, name: "Zeeshan Munir", profileImageURL: "https://via.placeholder.com/150?text=Zeeshan+Munir") // As we know, currently we have no information for current user. Therefore, i've included mock data for the commented user.
        }
    }
    
    func getCreatedPost() -> PostModel? {
        if let post {
            return post
        }
        return nil
    }
}
