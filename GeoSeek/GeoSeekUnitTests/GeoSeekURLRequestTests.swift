//
//  GeoSeekURLRequestTests.swift
//  GeoSeekUnitTests
//
//  Created by morse on 7/30/20.
//  Copyright © 2020 Brandi Bailey. All rights reserved.
//

import XCTest
@testable import GeoSeek

class GeoSeekURLRequestTests: XCTestCase {

    func testGsGemURL() {
        let url = URL(string: "https://geoseek-be-stage.herokuapp.com/api/")
        let method = HTTPMethod.get
        let request = URLRequest.gsGemURL(from: url!, with: method)
        
        print(request.description)
        
        XCTAssertEqual(request.description, "https://geoseek-be-stage.herokuapp.com/api/gems")
    }

}
