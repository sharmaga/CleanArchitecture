//
//  AgenciesAPIEndpoint.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//


import Foundation

enum AgencyAPIEndpoint {
    case getListOfAgencies(pageIndex: Int)
}

extension AgencyAPIEndpoint: EndPointType {
    
    var baseURL: URL? {
        let url = URL(string: "https://www.gov.uk/api")
        return url!
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

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}





