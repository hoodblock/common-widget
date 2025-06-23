//
//  WidgetSettingView.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/28.
//

import SwiftUI


struct WidgetSettingView: View {

    @State private var showInsterAds: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var lightModel: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                HStack (alignment: .center, spacing: 0) {
                    Spacer()
                    Text("How to add components & change component style on the desktop?")
                        .foregroundColor(Color.Color_454545)
                        .font(Font.S_Pro_20(.medium))
                    Spacer()
                }
                
                ScrollView (showsIndicators: false, content: {
                    
                    VStack (alignment: .center, spacing: ViewLayout.SWidth(30)) {
                        
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("1.Long press the home screen and click the "+" sign in the upper left corner.")
                                Spacer()
                            }
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                VStack (alignment: .leading, spacing: 0) {
                                    GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                                            path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.black)
                                    }
                                }
                                .frame(width: ViewLayout.SWidth(10))
                                Spacer()
                                    Image("setting_setting_1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("2.Found“Focus Widgets”.")
                                Spacer()
                            }
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                VStack (alignment: .leading, spacing: 0) {
                                    GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                                            path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.black)
                                    }
                                }
                                .frame(width: ViewLayout.SWidth(10))
                                Spacer()
                                    Image("setting_setting_2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("3.Select the size and click \"Add Widget\".")
                                Spacer()
                            }
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                VStack (alignment: .leading, spacing: 0) {
                                    GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                                            path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.black)
                                    }
                                }
                                .frame(width: ViewLayout.SWidth(10))
                                Spacer()
                                    Image("setting_setting_3")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("4.Go back to the home screen, long press the widget, and select \"Edit widget\"")
                                Spacer()
                            }
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                VStack (alignment: .leading, spacing: 0) {
                                    GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                                            path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.black)
                                    }
                                }
                                .frame(width: ViewLayout.SWidth(10))
                                Spacer()
                                    Image("setting_setting_4")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("5.Select the widget style you want.")
                                Spacer()
                            }
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(10)) {
                                VStack (alignment: .leading, spacing: 0) {
                                    GeometryReader { geo in
                                        Path { path in
                                            path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                                            path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                                        }
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.black)
                                    }
                                }
                                .frame(width: ViewLayout.SWidth(10))
                                Spacer()
                                    Image("setting_setting_5")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor(Color.Color_333333)
                    .font(Font.S_Pro_14(.regular))
                })
                .padding([.leading, .trailing], ViewLayout.SWidth(20))
            }
            .padding(ViewLayout.SWidth(20))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Color_F6F6F6)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Widget Setting")
        .toolbarBackground(.white, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            showInsterAds = true
        }, lightModel: $lightModel))        
        .presentInterstitialAd(isPresented: $showInsterAds, adModel: FirebaseNetwork.shared.loadInterstitialAdViewModel().0, showedBlock: {
            showInsterAds = false
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
}
