//
//  CarManufacturerPaginationServiceImpl.swift
//  HomeAssignment
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

class AgencyPaginationServiceImpl: AgencyPaginationService {
  
    private var service: AgencyHttpService?
    private var page: Page? = nil
    private var data: AgencyDTO? = nil

    init(httpService: AgencyHttpService) {
        self.service = httpService
    }
    
    func fetchData() async -> AgencyDTO? {
        
        if let _ = self.page {
            await nextPage()
            guard let data = await self.service?.getAgencies(pageIndex: self.page!.index),
                  let list = data.list else { return nil }
            self.page = Page(index: data.currentIndex, size: data.pageSize, total: data.totalPageCount)
            self.data?.currentIndex = data.currentIndex
            self.data?.pageSize = data.pageSize
            self.data?.totalPageCount = data.totalPageCount
            self.data?.list?.append(contentsOf: list)
            return self.data
        }
        else {
            let newPage = Page(index: 1, size: 15, total: 0)
            guard let data = await self.service?.getAgencies(pageIndex: newPage.index) else { return nil }
            self.page = Page(index: data.currentIndex, size: data.pageSize, total: data.totalPageCount)
            self.data = data
            return data
        }
    }
}

extension AgencyPaginationServiceImpl: Pageable {
    
    func nextPage() async {
        if let page = self.page, page.index < page.total {
            self.page?.index+=1
        }
    }
}




