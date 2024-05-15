//
//  PostListViewModel.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation

final class PostListViewModel {
    var dataSource: [PostModel]?
    var posts: Observable<[PostTableCellViewModel]> = Observable(nil)
    var eventHandler: Observable<Event> = Observable(nil)
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func fetchPostList() {
        eventHandler.value = .loading
        let endPoint = PostEndPoints.fetchPosts
        do {
            let request = try endPoint.asURLRequest()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: [PostModel].self) { (response) in
                self.eventHandler.value = .stopLoading
                switch response {
                case .success(let data):
                    self.dataSource = data
                    self.mapPostData()
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
    
    func updatePostLike(id: Int) {
        eventHandler.value = .loading
        let endPoint = PostEndPoints.postLike
        do {
            let request = try endPoint.asURLRequest()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: PostLikeModel.self) { (response) in
                self.eventHandler.value = .stopLoading
                switch response {
                case .success(let data):
                    self.mapPostData()
                    self.updatePostLikeState(at: id)
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
    
    private func mapPostData() {
        posts.value = self.dataSource?.compactMap({PostTableCellViewModel(post: $0)})
    }
    
    func updatePostLikeState(at index: Int) {
        if let dataSource, let isLiked = dataSource[index].isLiked {
            let count = dataSource[index].likeCount ?? 0
            dataSource[index].likeCount = isLiked ? (count - 1) : (count + 1)
            dataSource[index].isLiked = !(dataSource[index].isLiked ?? false)
            self.mapPostData()
        }
    }
    
    func retrivePost(at index: Int) -> PostModel? {
        guard let dataSource else {
            return nil
        }
        return dataSource[index]
    }
    
    func insertNewPostAndRefresh(post: PostModel) {
        if var _ = dataSource {
            dataSource?.insert(post, at: 0)
        } else {
            dataSource = [post]
        }
        self.mapPostData()
    }
}
