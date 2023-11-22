//
//  AgencyDTO.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//


import Foundation

struct AgencyDTO: Codable {
    
    var list: [AgencyObject]?
    var currentIndex: Int
    var pageSize: Int
    var totalPageCount: Int
    
    enum CodingKeys: String, CodingKey {
        case list = "results"
        case currentIndex = "current_page"
        case pageSize = "page_size"
        case totalPageCount = "pages"
    }
}

struct AgencyObject: Codable {
    var title: String?
    var details: AgencyDetail?
    var webUrl: URL
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case details = "details"
       case webUrl = "web_url"
    }
}

struct AgencyDetail: Codable {
    var abbreviation: String?
    
    enum CodingKeys: String, CodingKey {
        case abbreviation = "abbreviation"
    }
}
