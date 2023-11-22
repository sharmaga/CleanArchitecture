//
//  JsonDataParserTests.swift
//  UKGovGuideTests
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import XCTest

@testable import UKGovGuide

final class JsonDataParserTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsedDataNotNil() async throws {
        
        let httpService: HttpService = MockHttpServiceImpl()
        let endPoint: EndPointType =  AgencyAPIEndpoint.getListOfAgencies(pageIndex: 1)
        
        let urlRequest = endPoint.buildUrlRequest()!
        let result = await httpService.getData(request: urlRequest)
        switch result {
        case .success(let data):
            let parsedData = JsonDataParser<AgencyDTO>.parseData(data: data)
            XCTAssertNotNil(parsedData)
        default: break
        }
    }
    
    func testParsedDataNil() async throws {
        
        let parsedData = JsonDataParser<AgencyDTO>.parseData(data: Data())
        XCTAssertNil(parsedData)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
