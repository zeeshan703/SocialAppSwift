//
//  ViewController.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 12/05/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getPosts()
    }
    
    
    private func getPosts() {
        let endPoint = PostEndPoints.fetchPosts
        do {
            let request = try endPoint.asURLRequest()
            APIManager.sharedInstance.makeRequet(request: request, dataReturnType: [PostModel].self) { (response) in
                switch response {
                case .success(let genericObject):
                    print("Content of posts: \(genericObject)")
//                    guard let obj = genericObject.data else {
//                            completionHandler(nil, AppError.parseFailed(reason: ParseFailureReason(code: -1)))
//                            return
//                    }
//                    completionHandler(obj, nil)
                case .failure(let error):
                    print("Error Occured: \(error)")
//                    completionHandler(nil, error)
                }
            }
        } catch {
            print("Error Occured in catch: \(error)")
//            completionHandler(nil, AppError.internalFailed(reason: error))
        }
    }


}

