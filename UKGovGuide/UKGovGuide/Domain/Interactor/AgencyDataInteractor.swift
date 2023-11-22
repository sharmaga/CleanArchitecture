//
//  AgenciesDataInteractor.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import Foundation
import Combine

protocol AgencyDataInteractor {
    func loadGovAgencies()  async -> AgencyDTO?
}

class AgencyDataInteractorImpl: AgencyDataInteractor {
    
    private let agencyPaginationService: AgencyPaginationService
    
    init(agencyPaginationService: AgencyPaginationService) {
        self.agencyPaginationService = agencyPaginationService
    }
    
    func loadGovAgencies()  async -> AgencyDTO? {
        guard let govAgencyObject = await self.agencyPaginationService.fetchData() else { return nil }
        return govAgencyObject
    }
}

