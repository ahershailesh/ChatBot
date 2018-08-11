//
//  NetworkTest.swift
//  MerPayAssignmentTests
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import XCTest
@testable import MerPayAssignment

class MockNetworkService : NetworkSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask {
        return URLSessionDataTask()
    }
}

class NetworkTest: XCTestCase {
    
    override func setUp() {
        
    }
    
}
