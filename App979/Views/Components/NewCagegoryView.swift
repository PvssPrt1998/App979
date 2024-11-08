import UIKit
import SwiftUI
import WebKit
import Combine

struct LeaderboardWeeklyView: UIViewRepresentable {
    
    enum URLType {
        case local, `public`
    }
    
    var type: URLType
    var url: String? = ViewModelFactory.shared.myLineWordCheck
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: LeaderboardWeeklyView
        var webViewNavigationSubscriber: AnyCancellable? = nil
        
        init(_ webView: LeaderboardWeeklyView) {
            self.parent = webView
        }
        
        deinit {
            webViewNavigationSubscriber?.cancel()
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            if let urlStr = navigationAction.request.url?.absoluteString {

            }
            decisionHandler(.allow, preferences)
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let url = webView.url?.absoluteString {
                if verifyUrl(urlString: url) {
                    ViewModelFactory.shared.myLineWordCheck = url
                }
            }
        }
        
        func verifyUrl (urlString: String?) -> Bool {
            if let urlString = urlString {
                if let url = NSURL(string: urlString) {
                    return UIApplication.shared.canOpenURL(url as URL)
                }
            }
            return false
        }
    }
}
