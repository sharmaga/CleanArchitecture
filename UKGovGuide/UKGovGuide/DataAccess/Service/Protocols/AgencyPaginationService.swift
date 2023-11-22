//
//  AgenciesPaginationService.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

protocol AgencyPaginationService {
    func fetchData() async  -> AgencyDTO?
}
