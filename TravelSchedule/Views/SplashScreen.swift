//
//  SplashScreen.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 09.02.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive: Bool = false

    var body: some View {
        ZStack(alignment: .center) {
            if self.isActive {
                MainTabView()
            } else {
                Rectangle()
                    .background(Color.ypBlack)
                Image("SplashScreen")
                    .resizable()
                    .ignoresSafeArea(.all)
                    .scaledToFill()
//                    .frame(width: .infinity, height: .infinity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen()
}
