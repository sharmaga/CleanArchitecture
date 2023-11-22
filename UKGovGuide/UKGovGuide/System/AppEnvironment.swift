//
//  AppEnvironment.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//


import UIKit
import Combine

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        
        let presenters = configuredPresenters()
        let diContainer = DIContainer(presenters: presenters)

        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredPresenters(
    ) -> DIContainer.Presenters {
        
        let httpService: HttpService = HttpServiceImpl()
        let agencyHttpService: AgencyHttpService = AgencyHttpServiceImpl(httpService: httpService)
        let agencyPaginationService: AgencyPaginationService = AgencyPaginationServiceImpl(httpService: agencyHttpService)
        let agencyDataInteractor: AgencyDataInteractor = AgencyDataInteractorImpl(agencyPaginationService: agencyPaginationService)
        let presentationDataBuilder: AgencyPresentationDataBuilder = AgencyPresentationDataBuilderImpl()
        let govAgencyDataPresenter: AgencyDataPresenter = AgencyDataPresenterImpl(interactor: agencyDataInteractor, presentationDataBuilder: presentationDataBuilder)
        
        return .init(agencyDataPresenter: govAgencyDataPresenter)
    }
}



