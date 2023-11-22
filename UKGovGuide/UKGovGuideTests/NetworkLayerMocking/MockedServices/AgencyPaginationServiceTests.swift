//
//  AgencyPaginationServiceTests.swift
//  UKGovGuideTests
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import XCTest

@testable import UKGovGuide

final class AgencyPaginationServiceTests: XCTestCase {
    
    var sut:  AgencyPaginationService?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let httpService = MockHttpServiceImpl()
        let agencyHttpService = AgencyHttpServiceImpl(httpService: httpService)
        self.sut = AgencyPaginationServiceImpl(httpService: agencyHttpService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_govAgencyDTOObjectNotNil() async {
        let dtoObject = await sut?.fetchData()
        XCTAssertNotNil(dtoObject)
    }
    
    func test_govAgencyDTOObjectNilForFirstPage() async {
    
        var mockService = MockHttpServiceImpl()
        mockService.returnNil = true
        let agencyHttpService = AgencyHttpServiceImpl(httpService: mockService)
        let sut = AgencyPaginationServiceImpl(httpService: agencyHttpService)
        let dtoObjectFirstPage = await sut.fetchData()
        XCTAssertNil(dtoObjectFirstPage)
    }
    
    func test_govAgencyDTOObjectNilForNextPage() async {
    
        var mockService = MockHttpServiceImpl()
        let agencyHttpService = AgencyHttpServiceImpl(httpService: mockService)
        let sut = AgencyPaginationServiceImpl(httpService: agencyHttpService)
        let _ = await sut.fetchData()
        mockService.returnNil = true
        let dtoObjectNextPage = await sut.fetchData()
        XCTAssertNil(dtoObjectNextPage)
    }
    
    func test_govAgencyDTOObjectPagination() async {
        
        var dtoObject = await sut?.fetchData()
        XCTAssertEqual(dtoObject?.currentIndex, 1)
        dtoObject =  await sut?.fetchData()
        XCTAssertEqual(dtoObject?.currentIndex, 2)
        dtoObject =  await sut?.fetchData()
        XCTAssertEqual(dtoObject?.currentIndex, 3)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockHttpServiceImpl: HttpService {
    
    var returnNil = false
    
    func getData(request: URLRequest) async -> Result<Data, HTTPServiceError> {
        if returnNil { return Result.failure(HTTPServiceError.invalidResponse) }
        let pageIndex = String(request.url?.absoluteString.last ?? "1")
        guard let data =  await readDataFromJsonFile(pageIndex: pageIndex) else { return Result.failure(HTTPServiceError.invalidResponse) }
        return Result.success(data)
    }
}

extension MockHttpServiceImpl {
    
    public func readDataFromJsonFile(pageIndex: String) async -> Data? {
        
        do {
            let fullFileName = "GovAgencyDTOJsonPage" + pageIndex
              if let filePath = Bundle.main.path(forResource: fullFileName, ofType: "json") {
                  let fileUrl = URL(fileURLWithPath: filePath)
                  let data = try Data(contentsOf: fileUrl)
                  return data
              }
          } catch {
              print("error: \(error)")
          }
        return nil
    }
}
