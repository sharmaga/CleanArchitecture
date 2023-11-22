//
//  APIEndPointTests.swift
//  UKGovGuideTests
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import XCTest

@testable import UKGovGuide

final class APIEndPointTests: XCTestCase {

    var agencyEndpoint: AgencyAPIEndpoint?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        agencyEndpoint = .getListOfAgencies(pageIndex: 1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEndPointUrlRequestNotNil() throws {
        let urlRequest = agencyEndpoint?.buildUrlRequest()
        XCTAssertNotNil(urlRequest)
    }
    
    func testEndPointUrlRequestDataValidation() throws {
        let urlRequest = agencyEndpoint?.buildUrlRequest()
        XCTAssertEqual( urlRequest?.url, URL(string: "https://www.gov.uk/api/organisations?page=1")!)
        XCTAssertEqual( urlRequest?.allHTTPHeaderFields, ["Content-Type": "application/json"])
    }
    
    func testEndPointNilUrlRequest() throws {
        let mockEndPoint: MockAgencyAPIEndpoint = .getListOfAgencies(pageIndex: -1)
        let urlRequest = mockEndPoint.buildUrlRequest()
        XCTAssertNil(urlRequest)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


enum MockAgencyAPIEndpoint {
    case getListOfAgencies(pageIndex: Int)
}

extension MockAgencyAPIEndpoint: EndPointType {
   
 var baseURL: URL? {
     return nil
 }
 
 var path: String {
     switch  self {
     case let .getListOfAgencies(pageIndex):
         return "/organisations?page=\(pageIndex)"
     }
 }
 
 var method: HttpMethod {
     switch  self {
     case .getListOfAgencies:
         return .get
     }
 }
 
 var token: String {
     return "............."
 }
 
 
 var headers: [String: String]? {
     return ["Content-Type": "sdfs/json"]
 }
}
 
