//
//  AgencyPresenationData.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import Foundation

@Observable class AgencyPresenationData {
    var list: [AgencyPresenationObject]
    var currentPage: Int

    init(list: [AgencyPresenationObject], currentPage: Int) {
        self.list = list
        self.currentPage = currentPage
    }
    
    static func defaultObject() -> AgencyPresenationData {
        var list = [AgencyPresenationObject]()
        list.append( AgencyPresenationObject(title: "UK Government", abbreviation: "UKGOV"))
        return AgencyPresenationData(list: list, currentPage: 1)
    }
}

struct AgencyPresenationObject: Identifiable {
    
    var id: Int
    var title: String
    var abbreviation: String
    var webUrl: URL
    
    init(id: Int = 0, title: String, abbreviation: String, webUrl:URL = URL(string: "https://www.gov.uk")!) {
        self.id = id
        self.title = title
        self.abbreviation = abbreviation
        self.webUrl = webUrl
    }
}
