//
//  AgenciesHttpService.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

protocol AgencyHttpService {
    func getAgencies(pageIndex: Int) async -> AgencyDTO?
}
