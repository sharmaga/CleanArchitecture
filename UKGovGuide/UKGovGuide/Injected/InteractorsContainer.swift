//
//  InteractorsContainer.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

extension DIContainer {
    struct Presenters {
        let agencyDataPresenter: AgencyDataPresenter
        
        init(agencyDataPresenter: AgencyDataPresenter) {
            self.agencyDataPresenter = agencyDataPresenter
        }
        
        static var stub: Self {
            .init(agencyDataPresenter: StubAgencyDataPresenterImpl())
        }
    }
}
