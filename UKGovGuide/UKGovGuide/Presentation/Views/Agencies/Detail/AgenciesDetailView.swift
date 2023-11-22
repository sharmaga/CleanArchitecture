//
//  AgenciesDetailView.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import SwiftUI


struct AgencyDetailView: View {

    let agency: AgencyPresenationObject
    @StateObject var model: WebViewModel
    
    var body: some View {
        content
            .ignoresSafeArea()
    }
    
    @ViewBuilder private var content: some View {
        
        VStack {
            
            LoadingView(isShowing: self.$model.isLoading) {
                UIViewRepresentables.WebView(viewModel: self.model)
                    .navigationTitle(agency.title)
                    .navigationBarTitleDisplayMode(.inline)
                   }
        }
    }
    
}
