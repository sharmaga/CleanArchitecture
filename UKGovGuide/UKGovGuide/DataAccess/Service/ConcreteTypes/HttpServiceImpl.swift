//
//  HttpServiceImpl.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//


import Foundation
import UIKit

class HttpServiceImpl: HttpService {
    
    func getData(request: URLRequest) async -> Result<Data, HTTPServiceError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                return Result.success(data)
            }
            return Result.failure(HTTPServiceError.invalidResponse)
        }
        catch {
            return Result.failure(HTTPServiceError.invalidResponse)
        }
    }
}


