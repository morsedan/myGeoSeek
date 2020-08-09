//
//  GeoSeekUnitTests.swift
//  GeoSeekUnitTests
//
//  Created by morse on 7/29/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import XCTest

class GeoSeekUnitTests: XCTestCase {
    
    var sut: URLSession!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testValidCallToServerCompletes() {
        // Given
        let url = URL(string: "https://geoseek-be-stage.herokuapp.com/api/gems")
        let promise = expectation(description: "Completion handler invoked.")
        var statusCode: Int?
        var responseError: Error?
        // When
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        // Then
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(responseError, "An error was returned from the server")
    }
}
