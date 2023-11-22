//
//  GovAgenciesHttpServiceImpl.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

class AgencyHttpServiceImpl: AgencyHttpService {
    
    private var service: HttpService?
    
    init(httpService: HttpService) {
        self.service = httpService
    }
    
    func getAgencies(pageIndex: Int) async -> AgencyDTO? {
        
        let endpoint: AgencyAPIEndpoint = .getListOfAgencies(pageIndex: pageIndex)
        guard let urlRequest = endpoint.buildUrlRequest(),
              let result = await self.service?.getData(request: urlRequest),
              case .success(let data) = result else { return nil }
        let parsedData = JsonDataParser<AgencyDTO>.parseData(data: data)
        return parsedData
    }
}


