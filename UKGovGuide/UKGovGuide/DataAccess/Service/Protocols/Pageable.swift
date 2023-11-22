//
//  Pageable.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 20/11/23.
//

import Foundation

public struct Page {
    
    var index: Int
    let size: Int
    let total: Int
    
    init(index: Int, size: Int = 20, total: Int) {
        self.index = index
        self.size = size
        self.total = total
    }
}

public protocol Pageable {
     func nextPage() async
}
