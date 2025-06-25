//
//  WidgetEditorStatus.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/15.
//

import Foundation
import SwiftUI

struct WidgetEditorStatus: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var nativeModel: FirebaseAdsItemModel = FirebaseAdsItemModel()
    @State private var refreshFlag = false
    @State private var showInsterAds: Bool = false
    @State private var isShowMyCollectWidgetsView: Bool = false
    // 要切换的tabbar
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    @State var lightModel: Bool = false
    @State private var showWebView = false

    var body: some View {
        GeometryReader { geo in
            ScrollView (showsIndicators: false, content: {
                VStack (alignment: .center, spacing: ViewLayout.SWidth(20), content: {
                    // 静态状态
                    ZStack(alignment: .center) {
                        HStack (alignment: .center, spacing: 0) {
                            Spacer()
                            VStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                Image("widget_edit_status")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: ViewLayout.SWidth(100), height: ViewLayout.SWidth(100))
                                Text("Set successfully!")
                                    .font(Font.S_Pro_18(.medium))
                                    .foregroundColor(Color.Color_454545)
                                Text("There are more functions waiting for your exploration")
                                    .font(Font.S_Pro_12(.medium))
                                    .foregroundColor(Color.Color_A5A6BF)
                                    .lineLimit(2)
                            }
                            Spacer()
                        }
                        .padding(ViewLayout.SWidth(20))
                    }
                    .background(Color.Color_FFFFFF)
                    .cornerRadius(ViewLayout.SWidth(10))
                    
                    // native
                    if nativeModel.nativeAd != nil && nativeModel.ad_id.count > 0 {
                        SwiftUINativeView(objectSize: NATIVESIZE_200, admobModel: nativeModel)
                            .id(refreshFlag)
                    }
                })
                .padding(ViewLayout.SWidth(20))
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Color_F6F6F6)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            showInsterAds = true
        }, lightModel: $lightModel))
        .presentInterstitialAd(isPresented: $showInsterAds, adModel: FirebaseNetwork.shared.loadInterstitialAdViewModel().0, showedBlock: {
            showInsterAds = false
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        })
        .navigationTitle("Success")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.white, for: .navigationBar)
        .onAppear {
            nativeModel = FirebaseNetwork.shared.loadNativeAdViewModel().0
            if nativeModel.nativeAd != nil && nativeModel.ad_id.count > 0 {
                refreshFlag.toggle()
            }
        }
    }
   
}
