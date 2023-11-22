//
//  UKGovGuideApp.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import SwiftUI

@main
struct UKGovGuideApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(container: AppEnvironment.bootstrap().container)
        }
    }
}
