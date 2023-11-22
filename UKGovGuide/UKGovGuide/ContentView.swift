//
//  ContentView.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import SwiftUI

struct ContentView: View {
    
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        AgenciesListView()
            .inject(container)
    }
}

//#Preview {
//    ContentView(container: .preview)
//}
