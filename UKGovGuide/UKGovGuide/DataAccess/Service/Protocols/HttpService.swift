//
//  HttpService.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

enum HTTPServiceError: Error {
    case invalidResponse
    case noDataFound
}

protocol HttpService {
    
    func getData(request: URLRequest) async  -> Result<Data, HTTPServiceError>
    /*
    func postData(request: URLRequest) async throws -> Bool
    */
}
