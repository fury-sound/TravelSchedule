    //
    //  userAgreementView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 14.02.2025.
    //

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var isDarkMode: Bool
    let blackBGColor: String = "1A1B22"
        //    @Environment(\.colorScheme) var colorScheme

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        init(parent: WebView) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.isHidden = true
            parent.updateTheme(for: webView)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isHidden = true
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        let url = URL(string: "https://www.yandex.ru/legal/practicum_offer/")!
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.isHidden = true
        updateTheme(for: webView)
    }

//    layoutHead.style.display = 'none';
//    layoutHead.style.height = '0px';
//    layoutHead.style.visibility = 'hidden';
//    layoutHead.style.overflow = 'hidden';
//    layoutHead.remove();
//    document.querySelector('div.content__article-header').style.marginTop = '0px';
//    "\(blackBGColor)"

    private func updateTheme(for webView: WKWebView) {
//        document.body.style.backgroundColor = "\(blackBGColor)";
//        let outerBGColor: String = Color.ypBlack // "#1A1B22"
        let js = """
        (function() {
            let darkMode = \(isDarkMode ? "true" : "false");
            let layoutHead = document.querySelector('div.layout__head');
            if (layoutHead) {           
                layoutHead.remove();
                var parent = document.querySelector('.b-page layout b-page__body i-ua i-global i-bem b-page_js_inited i-ua_platform_other i-ua_js_inited i-global_js_inited');
                if (parent) {
                    parent.style.height = 'auto';
                }
            }
            if (darkMode) {
                document.documentElement.style.filter = "invert(1) hue-rotate(180deg)";
                document.querySelectorAll("img, video").forEach(el => el.style.filter = "invert(1) hue-rotate(180deg)");
                document.body.style.backgroundColor = "\(blackBGColor)";
                var articleBG = document.querySelector('article.doc-c-article');
                if (articleBG) {
                    articleBG.style.backgroundColor = "\(blackBGColor)";
                }
                document.body.style.cssText = "background-color: \(blackBGColor) !important;";
        
            } else {
                document.documentElement.style.filter = "";
                document.querySelectorAll("img, video").forEach(el => el.style.filter = "");
            }
        })();
        """
        DispatchQueue.main.async {
            webView.evaluateJavaScript(js)
        }
        webView.isHidden = false
    }
}


struct BackButtonUA: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        })
        {
            Image(systemName: "chevron.left")
                .foregroundColor(.ypBlack)
        }
    }
}

struct userAgreementView: View {
    @Binding var isDarkMode: Bool
    @Binding var showTabBar: Bool
    @Environment(\.dismiss) var dismiss
    let screenSize = UIScreen.main.bounds
        //    let urlString: String = "https://yandex.ru/legal/timetable_termsofuse/"
        //    let urlString: String = "https://yandex.ru/legal/practicum_offer"

    var body: some View {

        VStack {
            VStack {
                WebView(isDarkMode: $isDarkMode)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
                //            .ignoresSafeArea(edges: .bottom)
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Пользовательское соглашение").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButtonUA()
                }
            }
            if #available(iOS 18.0, *) {
                Text("")
                    .toolbarVisibility(.hidden, for: .tabBar) // for iOS 18.0
            } else {
                Text("")
                    .toolbar(.hidden, for: .tabBar) // deprecated
            }
        }
        .background(Color.ypWhite)
        .ignoresSafeArea(edges: .bottom)
        .onAppear() {
            showTabBar = false
        }
        .onDisappear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    showTabBar = true
                }
            }
        }
    }
}


#Preview("Dark Mode") {
    WebView(isDarkMode: .constant(true))
        .preferredColorScheme(.dark)
}

#Preview("Light Mode") {
    WebView(isDarkMode: .constant(false))
        .preferredColorScheme(.light)
}

    //#Preview {
    //    @State var isDarkMode = true
    //    WebView()
    //}
    //#Preview {
    //    @State var isDarkMode = false
    //    WebView(isDarkMode: $isDarkMode)
    //}
    //
    //#Preview {
    //    @State var isDarkMode = true
    //    userAgreementView(isDarkMode: $isDarkMode)
    //}
    //
    //#Preview {
    //    @State var isDarkMode = false
    //    userAgreementView(isDarkMode: $isDarkMode)
    //}




    //    func makeUIView(context: Context) -> WKWebView {
    //        let webView = WKWebView()
    //            //        webView.navigationDelegate = context.coordinator
    //        webView.isOpaque = false
    //        webView.backgroundColor = UIColor.clear
    //        let url = URL(string: "https://www.yandex.ru/legal/practicum_offer/")!
    //        let request = URLRequest(url: url)
    //        webView.load(request)
    //        return webView
    //    }
    //
    ////    let darkMode = true
    //        //        let isDarkMode = (colorScheme == .dark)
    //    func updateUIView(_ webView: WKWebView, context: Context) {
    //        let js = """
    //        (function() {
    //            let darkMode = \(isDarkMode ? "true" : "false");
    //
    //            if (darkMode) {
    //                document.documentElement.style.filter = "invert(1) hue-rotate(180deg)";
    //                document.querySelectorAll("img, video").forEach(el => el.style.filter = "invert(1) hue-rotate(180deg)");
    //            } else {
    //                document.documentElement.style.filter = "";
    //                document.querySelectorAll("img, video").forEach(el => el.style.filter = "");
    //            }
    //        })();
    //        """
    //        webView.evaluateJavaScript(js, completionHandler: nil)
    //    }
    //}

    //            .overlay(
    //                HStack {
    //                    Spacer()
    //                    VStack {
    //                        Button {
    //                            dismiss()
    //                        } label: {
    //                            Image(systemName: "xmark.square.fill")
    //                                .foregroundColor(.gray)
    //                                .font(.largeTitle)
    //                        }
    //                        .padding(.trailing, 20)
    //                        .padding(.top, 20)
    //                        Spacer()
    //                    }
    //                }
    //            )
    //            .simultaneousGesture(TapGesture().onEnded{
    //                dismiss()
    //            })

    //        .edgesIgnoringSafeArea(.all)
    //        .safeAreaInset(edge: .bottom) {
    //            Color.clear  // Прозрачный фон
    //                .frame(height: 0) // Убираем высоту
    //        }

    //        let hideControlsScript = """
    //        document.querySelector('header').style.display = 'none'; // Скрыть заголовок
    //        document.querySelector('.your-class-for-search').style.display = 'none'; // Скрыть лупу
    //        document.querySelector('footer').style.display = 'none'; // Скрыть футер
    //        """
    //        webView.evaluateJavaScript(hideControlsScript, completionHandler: nil)

    //func updateUIView(_ webView: WKWebView, context: Context) {
    //        //        if let url = URL(string: urlString) {
    //        //            let request = URLRequest(url: url)
    //        //            webView.load(request)
    //        //        }
    //    webView.load(URLRequest(url: URL(string: "https://yandex.ru/legal/practicum_offer")!))
    //        // Inject Light/Dark CSS
    //    let lightDarkCSS = ":root { color-scheme: light dark; }"
    //    let base64 = lightDarkCSS.data(using: .utf8)!.base64EncodedString()
    //
    //    let script = """
    //    javascript:(function() {
    //        var parent = document.getElementsByTagName('head').item(0);
    //        var style = document.createElement('style');
    //        style.type = 'text/css';
    //        style.innerHTML = window.atob('\(base64)');
    //        parent.appendChild(style);
    //    })()
    //"""
    //    let cssScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
    //    webView.configuration.userContentController.addUserScript(cssScript)
    //}
