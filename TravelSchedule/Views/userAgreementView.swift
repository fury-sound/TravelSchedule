    //
    //  userAgreementView.swift
    //  TravelSchedule
    //
    //  Created by Valery Zvonarev on 14.02.2025.
    //

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
        //    let url: URL
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
            //        webView.load(URLRequest(url: url))
    }
}

struct userAgreementView: View {
    let screenSize = UIScreen.main.bounds
    @Environment(\.dismiss) var dismiss
    let urlString: String = "https://yandex.ru/legal/timetable_termsofuse/"

    var body: some View {
        WebView(urlString: urlString)
            .overlay(
                HStack {
                    Spacer()
                    VStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.square.fill")
                                .foregroundColor(.gray)
                                .font(.largeTitle)
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 40)
                        Spacer()
                    }
                }
            )
            .ignoresSafeArea()
    }
}

#Preview {
    userAgreementView()
}
