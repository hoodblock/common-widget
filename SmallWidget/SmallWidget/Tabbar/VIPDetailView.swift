//
//  VIPDetailView.swift
//  SmallWidget
//
//  Created by Q801 on 2024/8/5.
//

import Foundation
import SwiftUI

struct VIPDetailView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var shouldAgree: Bool = true
    @ObservedObject var payConfig = PayConfig.shared
    @State var dismissBlock: () -> ()

    @State private var isLoading = false

    var body: some View {
        ZStack () {
            VStack () {
                Image("vip_detail_back_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            Color.Color_FFF8EE.opacity(0.6).edgesIgnoringSafeArea(.all)
                .overlay {
                    ZStack () {
                        VStack () {
                            // cloas
                            Spacer()
                                .frame(height: UIApplication.shared.windows.first?.safeAreaInsets.top ?? 50)
                            HStack () {
                                Spacer()
                                RoundedRectangle(cornerRadius:  ViewLayout.S_W_3() * 10  / 2)
                                    .frame(width: ViewLayout.S_W_3() * 10, height:  ViewLayout.S_W_3() * 10)
                                    .foregroundColor(Color.black).opacity(0.5)
                                    .overlay {
                                        Image("wallpaper_close")
                                            .onTapGesture {
                                                self.isLoading = false
                                                dismiss()
                                                dismissBlock()
                                            }
                                    }
                            }
                            .padding([.leading, .trailing], ViewLayout.S_W_20())
                            Spacer()
                            
                            // Detail
                            VStack (spacing: ViewLayout.S_W_30()) {
                                VStack () {
                                    // us
                                    HStack () {
                                        Image("vip_vip")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: ViewLayout.S_W_3() * 10, height:  ViewLayout.S_W_3() * 10)
                                        Text("Purchase VIP")
                                            .foregroundColor(Color.Color_393672)
                                            .font(Font.S_Pro_20(.bold))
                                    }
                                    VStack() {
                                        HStack () {
                                            Image("vip_pink_3")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                                            Text("Install exclusive widgets")
                                                .foregroundColor(Color.Color_393672)
                                                .font(Font.S_Pro_14(.regular))
                                            Spacer()
                                        }
                                        HStack () {
                                            Image("vip_pink_0")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                                            Text("100% No Ads")
                                                .foregroundColor(Color.Color_393672)
                                                .font(Font.S_Pro_14(.regular))
                                            Spacer()
                                        }
                                        HStack () {
                                            Image("vip_pink_4")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                                            Text("Unlimited download of beautiful wallpapers")
                                                .foregroundColor(Color.Color_393672)
                                                .font(Font.S_Pro_14(.regular))
                                            Spacer()
                                        }
                                        HStack () {
                                            Image("vip_pink_2")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_10() * 3, alignment: .center)
                                            Text("Experience the exclusive themes in advance")
                                                .foregroundColor(Color.Color_393672)
                                                .font(Font.S_Pro_14(.regular))
                                            Spacer()
                                        }
                                    }
                                }
                                // 选项
                                VStack (spacing: 40) {
                                    VStack () {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(payConfig.currentSelectedPID == ProductIdType.weekly ? Color.Color_8682FF : Color.clear)
                                            .frame(height: 60)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(payConfig.currentSelectedPID == ProductIdType.weekly ? Color.Color_F6F6F6 : Color.Color_D9D9D9.opacity(0.4))
                                                    .overlay {
                                                        HStack () {
                                                            Text("Week Plan")
                                                                .foregroundColor(Color.Color_393672)
                                                                .font(Font.S_Pro_16(.medium))
                                                            Spacer()
                                                            VStack () {
                                                                Text("$0.99")
                                                                    .foregroundColor(Color.Color_393672)
                                                                    .font(Font.S_Pro_14(.medium))
                                                                Text("≈ $0.14/day")
                                                                    .foregroundColor(Color.Color_393672).opacity(0.5)
                                                                    .font(Font.S_Pro_14(.medium))
                                                            }
                                                        }
                                                        .padding()
                                                    }
                                                    .padding(2)
                                            }
                                            .overlay(content: {
                                                HStack () {
                                                    VStack() {
                                                        Text("Limited Time Offer")
                                                            .padding([.leading,.trailing], 10)
                                                            .padding([.top, .bottom], 5)
                                                            .foregroundColor(Color.Color_FFFFFF)
                                                            .background(Color.Color_FF4300)
                                                            .font(Font.S_Pro_10(.regular))
                                                            .cornerRadius(5)
                                                            .offset(y: -10)
                                                        Spacer()
                                                    }
                                                    Spacer()
                                                    VStack () {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .frame(width: 40, height: 40)
                                                            .foregroundColor(Color.Color_FF4300)
                                                            .overlay {
                                                                Text("-83%")
                                                                    .foregroundColor(Color.Color_FFFFFF)
                                                                    .background(Color.Color_FF4300)
                                                                    .font(Font.S_Pro_14(.regular))
                                                                    .rotationEffect(.degrees(20))
                                                            }
                                                            .offset(x:15, y: -20)
                                                        Spacer()
                                                    }
                                                }
                                                .padding([.leading,.trailing], 10)
                                            })
                                            .onTapGesture {
                                                payConfig.currentSelectedPID = ProductIdType.weekly
                                            }
                                        HStack (spacing: 5) {
                                            Image("subscription_tips_icon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 10, height: 10)
                                            Text("Price returns to $5.99 in week 2. Auto-renewal. Cancel anytime.")
                                                .foregroundColor(Color.Color_393672)
                                                .font(Font.S_Pro_10(.regular))
                                                .lineLimit(0)
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                    }
                                   
                                    
                                    // 按钮
                                    VStack (spacing: 20) {
                                        RoundedRectangle(cornerRadius:  ViewLayout.S_W_10())
                                            .frame(height:  ViewLayout.S_W_5() * 10)
                                            .foregroundColor(Color.Color_8682FF)
                                            .overlay {
                                                ZStack () {
                                                    HStack () {
                                                        Spacer()
                                                        Text("Subscribe Now")
                                                            .font(Font.S_Pro_16(.medium))
                                                            .foregroundColor(Color.Color_FFFFFF)
                                                        Spacer()
                                                    }
                                                    HStack () {
                                                        Spacer()
                                                        Image("vip_to_right_icon")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: ViewLayout.S_W_10() * 3, height: ViewLayout.S_W_15(), alignment: .center)
                                                    }
                                                    .padding()
                                                }
                                            }
                                            .onTapGesture {
                                                isLoading = true
                                                if payConfig.payCheck == .systemFailed {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        self.isLoading = false
                                                    }
                                                } else {
                                                    payConfig.pay()
                                                }
                                            }
                                        HStack () {
                                            Button {
                                                UIApplication.shared.open(URL(string: "https://www.openwidget.top/privacy_policy.html")!, options: [:], completionHandler: nil)
                                            } label: {
                                                Text("Privacy policy")
                                                    .font(Font.S_Pro_12(.medium))
                                                    .foregroundColor(Color.Color_393672.opacity(0.4))
                                            }
                                            Spacer()
                                        
                                            
                                            Button {
                                                UIApplication.shared.open(URL(string: "https://t.me/+jKE_D2qfalNlZjk1")!, options: [:], completionHandler: nil)
                                            } label: {
                                                Text("Telegram")
                                                    .font(Font.S_Pro_12(.medium))
                                                    .foregroundColor(Color.Color_393672.opacity(0.4))
                                            }
                                            
                                            Spacer()
                                           
                                            Button {
                                                isLoading = true
                                                if payConfig.payCheck == .systemFailed {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                        self.isLoading = false
                                                    }
                                                } else {
                                                    payConfig.restorePurchases()
                                                }
                                            } label: {
                                                Text("Restore")
                                                    .font(Font.S_Pro_12(.medium))
                                                    .foregroundColor(Color.Color_393672.opacity(0.4))
                                            }
                                        }
                                    }
                                 
                                }
                            }
                            .padding([.leading, .trailing], ViewLayout.S_W_20())
                            .padding([.top], ViewLayout.S_W_20())
                            .padding([.bottom], ViewLayout.S_W_60())
                            .background(Color.Color_FFFFFF)
                            .cornerRadius(40, corners: [.topLeft, .topRight])
                        }
                        .edgesIgnoringSafeArea(.all)
                        
                        // 加载动画
                        if isLoading {
                            // 显示加载指示器
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray)
                                .frame(width: 100, height: 100)
                                .overlay {
                                    VStack () {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        Text(payConfig.payCheck == .systemFailed ? payConfig.payCheck.rawValue : payConfig.progress.rawValue)
                                            .font(Font.S_Pro_14(.medium))
                                            .foregroundColor(Color.Color_FFFFFF)
                                    }
                                   
                                }
                        }
                    }
                    .onChange(of: payConfig.progress) { newValue in
                        if !(payConfig.progress == .started || payConfig.progress == .purchasing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.isLoading = false
                            }
                        }
                    }
                    .onChange(of: payConfig.isPaied) { newValue in
                        if newValue {
                            dismissBlock()
                        }
                    }
                }
        }
        .edgesIgnoringSafeArea(.all)
    }

}
