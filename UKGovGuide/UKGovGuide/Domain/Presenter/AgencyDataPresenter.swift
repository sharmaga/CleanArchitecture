//
//  GovAgencyDataPresenter.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import Foundation
import Combine

protocol AgencyPresentationDataBuilder {
    func build(object: AgencyDTO) async ->  AgencyPresenationData
}

protocol AgencyDataPresenter {
    func presentData() async -> AgencyPresenationData
}

class AgencyDataPresenterImpl: AgencyDataPresenter {
    
    private var presentationObject: AgencyPresenationData
    
    private var presentationDataBuilder: AgencyPresentationDataBuilder
    
    private var interactor: AgencyDataInteractor
    
    init(presentationObject: AgencyPresenationData = .defaultObject(), interactor: AgencyDataInteractor,
         presentationDataBuilder: AgencyPresentationDataBuilder) {
        self.presentationObject = presentationObject
        self.interactor = interactor
        self.presentationDataBuilder = presentationDataBuilder
    }
    
    func presentData() async -> AgencyPresenationData {
        
        guard let agencyDataObject = await self.interactor.loadGovAgencies() else { return AgencyPresenationData.defaultObject() }
        self.presentationObject = await presentationDataBuilder.build(object: agencyDataObject)
        return self.presentationObject
    }
}

struct AgencyPresentationDataBuilderImpl: AgencyPresentationDataBuilder {
    
    func build(object dtoObject: AgencyDTO) async -> AgencyPresenationData {
        
        var presentationObjects = [AgencyPresenationObject]()
        var id = 0
        dtoObject.list?.forEach {
            
            if let title = $0.title, let abbreviation = $0.details?.abbreviation,
               !title.isEmpty, !abbreviation.isEmpty {
                let presentationObject = AgencyPresenationObject(id: id, title: title, abbreviation: abbreviation, webUrl: $0.webUrl)
                presentationObjects.append(presentationObject)
                id+=1
            }
        }
        return AgencyPresenationData(list: presentationObjects, currentPage: dtoObject.currentIndex)
    }
}


class StubAgencyDataPresenterImpl: AgencyDataPresenter {
    
    func presentData() async -> AgencyPresenationData {
        return AgencyPresenationData.defaultObject()
    }
}

