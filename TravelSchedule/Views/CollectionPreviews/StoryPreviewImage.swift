//
//  StoryPreviewImage.swift
//  TravelSchedule
//
//  Created by Valery Zvonarev on 11.02.2025.
//

import SwiftUI

enum NavDests {
    case gallery
}

struct StoryPreviewImage: View {
    var previewImage: String
    //    @State var showFullImage: Bool = false
    @Binding var didSee: Bool
    @Binding var showFullImage: Bool
    @Binding var selectedStorySetIndex: Int
    @Binding var selectedTab: Int
    var imageBig: String = "big1"

//    func overlayView(didSee: Bool) -> some View {
//        if didSee == true {
//            RoundedRectangle(cornerRadius: 15)
////                .opacity(0.5)
//                .stroke(.clear, lineWidth: 0)
//        } else {
//            RoundedRectangle(cornerRadius: 15)
//                .stroke(.ypBlueUniversal, lineWidth: 4)
//        }
//    }

    var body: some View {

        ZStack(alignment: .bottomTrailing) {
            if didSee == true {
                Image(previewImage)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .opacity(0.5)

//                    .overlay(
//                        overlayView(didSee: didSee)
                        //                    didSee ? RoundedRectangle(cornerRadius: 15).stroke(.ypBlueUniversal, lineWidth: 4) as! RoundedRectangle : RoundedRectangle(cornerRadius: 15)

//                    )
            } else {
                Image(previewImage)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(.ypBlueUniversal, lineWidth: 4)
                    )
            }

            Text("Text Text Text Text Text Text T...")
                .foregroundColor(Color.white)
                .multilineTextAlignment(.leading)
                .font(.system(size: 12))
                .padding(.bottom, 12)
                .padding(.horizontal, 8)
                .lineLimit(3)
        }
        .frame(width: 92, height: 140)
    }
}

//#Preview("show full false") {
////    @State var showFullImage: Bool = false
////    @State var selectedStorySetIndex: Int = 0
//    StoryPreviewImage(previewImage: "Preview1")
//}

#Preview("show full false") {
    @State var showFullImage: Bool = false
    @State var selectedStorySetIndex: Int = 0
    @State var selectedTab = 0
    @State var didSee: Bool = false
    StoryPreviewImage(previewImage: "Preview1", didSee: $didSee, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
}

#Preview("show full true") {
    @State var showFullImage: Bool = false
    @State var selectedStorySetIndex: Int = 0
    @State var selectedTab = 0
    @State var didSee: Bool = true
    StoryPreviewImage(previewImage: "Preview1", didSee: $didSee, showFullImage: $showFullImage, selectedStorySetIndex: $selectedStorySetIndex, selectedTab: $selectedTab)
}

//#Preview("show full true") {
//    @State var showFullImage: Bool = true
//    @State var selectedStorySetIndex: Int = 0
//    StoryPreviewImage(previewImage: "Preview1", showFullImage: .constant(true), selectedStorySetIndex: $selectedStorySetIndex)
//}




// Navigation link
//var body: some View {
//    NavigationStack() {
//        ZStack(alignment: .bottom) {
//            NavigationLink(destination: StoryImageViewFull()) {
//                previewImage
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(.ypBlueUniversal, lineWidth: 4)
//                    )
//            }
//            Text("Text Text Text Text Text Text T...")
//                .foregroundColor(Color.white)
//                .multilineTextAlignment(.leading)
//                .font(.system(size: 12))
//                .padding(.bottom, 12)
//                .padding(.horizontal, 8)
//                .lineLimit(3)
//        }.frame(width: 92, height: 140)
//
//    }
//}
//}

// fullScreenCover & mavigationDestination
//@State private var showFullImage: Bool = false
//var body: some View {
//    NavigationStack() {
//        ZStack(alignment: .bottom) {
//            Button(action: {
//                withAnimation(.easeInOut(duration: 2)) {
//                    showFullImage.toggle()
//                }
//           }
//            }) {
//                previewImage
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 15)
//                            .stroke(.ypBlueUniversal, lineWidth: 4)
//                    )
//            }
//            .fullScreenCover(isPresented: $showFullImage) {
//                StoryImageViewFull()
//                    .transition(.move(edge: .leading))
//            }
//            Text("Text Text Text Text Text Text T...")
//                .foregroundColor(Color.white)
//                .multilineTextAlignment(.leading)
//                .font(.system(size: 12))
//                .padding(.bottom, 12)
//                .padding(.horizontal, 8)
//                .lineLimit(3)
//        }.frame(width: 92, height: 140)
//    }
//}

