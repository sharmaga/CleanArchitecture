//
//  AppState.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import Foundation


struct AppState: Equatable {
    var govAgencyData: GovAgencyPresenationData
}

extension AppState {
    struct GovAgencyPresenationData: Equatable {}
}
