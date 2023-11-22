//
//  DependencyInjector.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//


import SwiftUI
import Combine

public struct DIContainer: EnvironmentKey {
    
    let presenters: Presenters
    
    init(presenters: Presenters) {
        self.presenters = presenters
    }
    
   public static var defaultValue: Self { Self.default }
    
   private static let `default` = Self(presenters: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

//#if DEBUG
//extension DIContainer {
//    static var preview: Self {
//        .init(presenters: .stub)
//    }
//}
//#endif

// MARK: - Injection in the view hierarchy

extension View {
    
//    func inject(_ presenters: DIContainer.Presenters) -> some View {
//        let container = DIContainer(presenters: presenters)
//        return inject(container)
//    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
