//
//  AgencyDataPresenterTests.swift
//  UKGovGuideTests
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import XCTest
@testable import UKGovGuide

final class AgencyDataPresenterTests: XCTestCase {
    
    var httpService: HttpService? = nil
    var agencyHttpService: AgencyHttpService? = nil
    var agencyPaginationService: AgencyPaginationService? = nil
    var agencyDataInteractor: AgencyDataInteractor? = nil
    var agencyPresentationDataBuilder: AgencyPresentationDataBuilder? = nil
    var sut: AgencyDataPresenter? = nil
    var presenationObject: AgencyPresenationData? = nil

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpService = MockHttpServiceImpl()
        agencyHttpService = AgencyHttpServiceImpl(httpService: httpService!)
        agencyPaginationService  = AgencyPaginationServiceImpl(httpService: agencyHttpService!)
        agencyDataInteractor = AgencyDataInteractorImpl(agencyPaginationService: agencyPaginationService!)
        agencyPresentationDataBuilder = AgencyPresentationDataBuilderImpl()
        sut = AgencyDataPresenterImpl(interactor: agencyDataInteractor!, presentationDataBuilder: agencyPresentationDataBuilder!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        httpService = nil
        agencyHttpService = nil
        agencyPaginationService  = nil
        agencyDataInteractor = nil
        agencyPresentationDataBuilder = nil
        sut = nil
    }

    func test_presentationObjectNotNil() async {
        
        self.presenationObject = await sut?.presentData()
        XCTAssertNotNil(self.presenationObject)
    }
    
    func test_presentationObjectNotEmpty() async {
        if let list = await sut?.presentData().list {
            XCTAssertTrue(!list.isEmpty)
        }
    }
    
    func test_presentationObjectDataContainsValues() async {
        if let list = await sut?.presentData().list, let lastObject = list.last  {
            XCTAssertEqual(lastObject.title, "Agriculture and Horticulture Development Board")
            XCTAssertEqual(lastObject.abbreviation, "AHDB")
            XCTAssertEqual(lastObject.webUrl, URL(string:"https://www.gov.uk/government/organisations/agriculture-and-horticulture-development-board")!)
        }
    }
    
    func test_presentationObjectDataContainsMultipleDataSets() async  {
        if let list = await sut?.presentData().list {
            XCTAssertTrue(list.count > 1)
        }
    }
    
    func test_presentationObjectDataPagination() async  {
        self.presenationObject =  await sut?.presentData()
        XCTAssertEqual(self.presenationObject?.currentPage, 1)
        self.presenationObject =  await sut?.presentData()
        XCTAssertEqual(self.presenationObject?.currentPage, 2)
        self.presenationObject =  await sut?.presentData()
        XCTAssertEqual(self.presenationObject?.currentPage, 3)
    }
    
    func test_presentationObjectDataDefaultObject() async  {
        
        let presentationObject = await StubAgencyDataPresenterImpl().presentData()
        XCTAssertTrue(!presentationObject.list.isEmpty)
        
        if let firstObject = presentationObject.list.first {
            XCTAssertEqual(firstObject.title, "UK Government")
            XCTAssertEqual(firstObject.abbreviation, "UKGOV")
            XCTAssertEqual(firstObject.webUrl, URL(string: "https://www.gov.uk")!)
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

