//
//  PostTests.swift
//  SocialAppSwiftTests
//
//  Created by Zeeshan Munir  on 14/05/2024.
//

import XCTest
@testable import SocialAppSwift

final class PostTests: XCTestCase {
    
    var viewModel: PostListViewModel = PostListViewModel()

    func testFetchPostList() {
        // Set up expectation
        let expectation = XCTestExpectation(description: "Fetch posts from API")
        
        // Perform fetch
        viewModel.fetchPostList()
        
        // Wait for fetch to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        
        // Wait for expectation
        wait(for: [expectation], timeout: 2.0)
        
        // Assert that data source is not nil after fetch
        XCTAssertNotNil(viewModel.dataSource, "Data source should not be nil after fetch")
    }
}
