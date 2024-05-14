//
//  PostDetailViewModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

final class PostDetailViewModel {
    var dataSource: [PostModel]?
    var eventHandler: Observable<Event> = Observable(nil)
    var comments: Observable<[PostCommentViewModel]> = Observable(nil)
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    
    func fetchComments(postId: Int) {
        eventHandler.value = .loading
        let endPoint = PostEndPoints.fetchComments(postId: postId)
        do {
            let request = try endPoint.asURLRequest()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: [PostModel].self) { (response) in
                self.eventHandler.value = .stopLoading
                switch response {
                case .success(let data):
                    self.dataSource = data
                    self.mapCommentsData()
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
    
    func addNewCommentRequest(postId: Int, message: String) {
        eventHandler.value = .loading
        let endPoint = PostEndPoints.addNewComment(postId: postId, message: message)
        do {
            let request = try endPoint.asURLRequestJsonPlaceholder()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: PostModel.self) { (response) in
                self.eventHandler.value = .stopLoading
                switch response {
                case .success(let data):
                    self.sendCommentMessage(message: data.comment ?? "")
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
    
    private func mapCommentsData() {
        comments.value = self.dataSource?.compactMap({PostCommentViewModel(comment: $0)})
    }
    
    func sendCommentMessage(message: String) {
        let comment = PostModel()
        comment.comment = message
        comment.user = User(userId: 11, name: "Zeeshan Munir", profileImageURL: "https://via.placeholder.com/150?text=Zeeshan+Munir") // As we know, currently we have no information for current user. Therefore, i've included mock data for the commented user.
        dataSource?.insert(comment, at: 0)
        mapCommentsData()
    }
}
