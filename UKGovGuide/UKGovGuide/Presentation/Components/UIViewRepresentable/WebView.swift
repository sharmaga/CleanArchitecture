//
//  SwiftUIWebView.swift
//  UKGovGuide
//
//  Created by Gagandeep Sharma on 17/11/23.
//


import SwiftUI
import WebKit

final class WebViewModel: ObservableObject {
    @Published var url: String
    @Published var isLoading: Bool = true
    
    init (url: String) {
        self.url = url
    }
}


extension UIViewRepresentables {
    
    struct WebView: UIViewRepresentable {
        
        @ObservedObject var viewModel: WebViewModel
        let webView = WKWebView()

        func makeCoordinator() -> Coordinator {
            Coordinator(self.viewModel)
        }
        
        class Coordinator: NSObject, WKNavigationDelegate {
            private var viewModel: WebViewModel
            
            init(_ viewModel: WebViewModel) {
                self.viewModel = viewModel
            }

            func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                self.viewModel.isLoading = false
            }
        }
        
        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<WebView>) { }
        
        func makeUIView(context: Context) -> UIView {
            self.webView.navigationDelegate = context.coordinator

            if let url = URL(string: self.viewModel.url) {
                self.webView.load(URLRequest(url: url))
            }

            return self.webView
        }
    }
}
