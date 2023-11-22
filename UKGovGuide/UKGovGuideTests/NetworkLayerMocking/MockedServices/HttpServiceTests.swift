//
//  HttpServiceTests.swift
//  UKGovGuideTests
//
//  Created by Gagandeep Sharma on 21/11/23.
//

import XCTest
@testable import UKGovGuide

final class HttpServiceTests: XCTestCase {
    
    var httpService: HttpService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpService = HttpServiceImpl()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        httpService = nil
    }

    func testHttpReturnsError() async throws {
        let url = URL(string: "hpejeh:73487345hsdhf")!
        let result = await httpService?.getData(request: URLRequest(url: url))
        
        if case .failure(let error) = result {
            XCTAssertEqual(error, HTTPServiceError.invalidResponse)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
