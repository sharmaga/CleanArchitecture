//
//  AgenciesListView.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//


import SwiftUI
import WebKit


struct AgenciesListView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private(set) var presentationObject: AgencyPresenationData = AgencyPresenationData.defaultObject()
    @State private(set) var showLoader: Bool = false
    var count = 0
    
    private  func fetchListOfGovAgencies() {
        showLoader = true
        Task {
            self.presentationObject = await self.injected.presenters.agencyDataPresenter.presentData()
            showLoader = false
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            LoadingView(isShowing: $showLoader) {
                
                ScrollViewReader { scrollViewProxy in
                    List(self.presentationObject.list, id: \.id) { agency in
                        
                        NavigationLink(destination: AgencyDetailView(agency: agency, model: WebViewModel(url: agency.webUrl.absoluteString)) ) {
                            AgencyRow(agency: agency)
                                .onAppear{
                                    if agency.id == self.presentationObject.list.count - 1,
                                       self.presentationObject.currentPage <= 59 {
                                        fetchListOfGovAgencies()
                                        scrollViewProxy.scrollTo(agency.id, anchor: .bottom)
                                    }
                                }
                        }
                    }
                    .onAppear {
                        fetchListOfGovAgencies()
                        print("Appear")
                    }
                }
                .navigationTitle("UK Gov Agencies")
                .listStyle(.automatic)
            }
        }
    }
}


struct AgencyRow: View {
    
    private let agency: AgencyPresenationObject
    
    init(agency: AgencyPresenationObject) {
        self.agency = agency
    }
    
    var body: some View {
        HStack {
            Text(agency.abbreviation)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
                .border(.primary)
                .background(.gray)
                .fontWeight(.semibold)
                .padding()
            Text(agency.title)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            Spacer()
        }
        
    }
}
