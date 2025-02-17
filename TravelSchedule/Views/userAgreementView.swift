    //
    //  userAgreementView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 14.02.2025.
    //

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

struct userAgreementView: View {
    let screenSize = UIScreen.main.bounds
    @Environment(\.dismiss) var dismiss
//    let urlString: String = "https://yandex.ru/legal/timetable_termsofuse/"
    let urlString: String = "https://yandex.ru/legal/practicum_offer"

    var body: some View {

        VStack {
            WebView(urlString: urlString)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Пользовательское соглашение").navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButtonView()
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
}

#Preview {
    userAgreementView()
}

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
