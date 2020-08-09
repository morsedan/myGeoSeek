//
//  GeoSeekFakeTests.swift
//  GeoSeekUnitTests
//
//  Created by morse on 7/29/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import XCTest
@testable import GeoSeek

class GeoSeekFakeTests: XCTestCase {
    
    var sut: NetworkController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkController()
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Gems", ofType: "json")
        print(testBundle)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: "anyString")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let sessionMock = MockURLSession(data: data, response: urlResponse, error: nil)
        
        sut.defaultSession = sessionMock
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_fetchGems_ParsesData() {
        var results: [Gem] = []
        let promise = expectation(description: "Status code: 200")
        XCTAssertEqual(results.count, 0, "results should be 0")
        
        sut.fetchGems { result in
            switch result {
            case .success(let gems):
                results = gems
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(results.count, 3)
    }
}
