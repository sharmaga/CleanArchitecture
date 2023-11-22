//
//  DataParser.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

protocol DataParser {
    associatedtype T: Codable
    func parseData(data:Data) -> T
}
