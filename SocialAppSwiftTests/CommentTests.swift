//
//  CommentTests.swift
//  SocialAppSwiftTests
//
//  Created by Zeeshan Munir  on 14/05/2024.
//

import XCTest
@testable import SocialAppSwift

final class CommentTests: XCTestCase {

    var viewModel: PostDetailViewModel = PostDetailViewModel()

    func testFetchCommentsSuccess() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Fetch comments from API")
        
        // Perform fetch
        viewModel.fetchComments(postId: 0)
        
        // Wait for fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 2.0)
        
        // Assert that data source is not nil after fetch
        XCTAssertNotNil(viewModel.dataSource, "Data source should not be nil after fetch")
        XCTAssertEqual(viewModel.comments.value?.count, viewModel.dataSource?.count, "Comments count should match")
    }
    
    func testAddNewCommentSuccess() {
        // Arrange
        let newComment = PostModel()
        
        let expectation = XCTestExpectation(description: "Add new comment")
        
        viewModel.comments.bind { _ in
            expectation.fulfill()
        }
        
        // Act
        viewModel.addNewCommentRequest(postId: 1, message: "New Comment")
        
        // Wait for expectation
        wait(for: [expectation], timeout: 2.0)
        
        // Assert
        XCTAssertEqual(viewModel.dataSource?.first?.comment, newComment.comment, "First comment in data source should be the newly added comment")
    }

}
