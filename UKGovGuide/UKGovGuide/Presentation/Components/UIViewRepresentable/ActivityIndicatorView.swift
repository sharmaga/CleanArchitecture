//
//  SwiftUIActivityIndicatorView.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//

import SwiftUI

extension UIViewRepresentables {
    
    struct ActivityIndicatorView: UIViewRepresentable {
        
        @Binding var isAnimating: Bool
        let style: UIActivityIndicatorView.Style
        
        func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
            return UIActivityIndicatorView(style: style)
        }
        
        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        }
    }
}
