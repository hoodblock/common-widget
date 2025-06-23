//
//  TransparentView.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/28.
//

import SwiftUI

struct TransparentView: View {

    @State private var isPresented = false
    
    @State private var showImageLightPicker = false
    
    @State private var showImageDarkPicker = false

    @State private var selectedLightImageData: String?

    @State private var selectedDarkImageData: String?

    @State private var showInsterAds: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var lightModel: Bool = false

    var body: some View {
        GeometryReader { geo in
            ScrollView (showsIndicators: false, content: {
                VStack (alignment: .center, spacing: ViewLayout.SWidth(20), content: {
                    // tetx
                    HStack (alignment: .center, spacing: 0) {
                        Spacer()
                        Text("Capture the blank desktop and upload screenshots in light and dark modes respectively")
                            .foregroundColor(Color.Color_A5A6BF)
                            .font(Font.S_Pro_16(.regular))
                        Spacer()
                    }
                    // 图片
                    HStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            Text("Light Mode")
                                .foregroundColor(Color.Color_454545)
                            ZStack (alignment: .center) {
                                Image("setting_screen_light")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Image(uiImage: UIImage(data: Data(base64Encoded: self.selectedLightImageData ?? "") ?? Data()) ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .cornerRadius(ViewLayout.SWidth(15))
                            Button {
                                showImageLightPicker.toggle()
                            } label: {
                                Text("Upload")
                                    .foregroundColor(Color.Color_FFFFFF)
                                    .frame(width: ViewLayout.SWidth(100), height: ViewLayout.SWidth(35))
                                    .background(Color.Color_8682FF)
                                    .cornerRadius(ViewLayout.SWidth(35) / 2)
                            }
                            .sheet(isPresented: $showImageLightPicker) {
                                ImagePicker { uiImage in
                                    withAnimation {
                                        if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                                            self.selectedLightImageData = imageData.base64EncodedString()
                                            UserDefaults.standard.setValue(imageData.base64EncodedString(), forKey: DeviceInfoUtil.getappName() + "UploadImageLightString")
                                            UserDefaults(suiteName: "group.com.subfg")!.setValue(imageData.base64EncodedString(), forKey: "UploadImageLightString")
                                            UserDefaults.standard.synchronize()
                                        }
                                    }
                                }
                            }
                        }
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                            Text("Dark Mode")
                                .foregroundColor(Color.Color_454545)
                            ZStack (alignment: .center) {
                                Image("setting_screen_dark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Image(uiImage: UIImage(data: Data(base64Encoded: self.selectedDarkImageData ?? "") ?? Data()) ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            .cornerRadius(ViewLayout.SWidth(15))
                            Button {
                                showImageDarkPicker.toggle()
                            } label: {
                                Text("Upload")
                                    .foregroundColor(Color.Color_FFFFFF)
                                    .frame(width: ViewLayout.SWidth(100), height: ViewLayout.SWidth(35))
                                    .background(Color.Color_8682FF)
                                    .cornerRadius(ViewLayout.SWidth(35) / 2)
                            }
                            .sheet(isPresented: $showImageDarkPicker) {
                                ImagePicker { uiImage in
                                    withAnimation {
                                        if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                                            self.selectedDarkImageData = imageData.base64EncodedString()
                                            UserDefaults.standard.setValue(imageData.base64EncodedString(), forKey: DeviceInfoUtil.getappName() + "UploadImageDarkString")
                                            UserDefaults(suiteName: "group.com.subfg")!.setValue(imageData.base64EncodedString(), forKey: "UploadImageDarkString")
                                            UserDefaults.standard.synchronize()
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .font(Font.S_Pro_18(.medium))
                    
                    // 提醒
                    VStack (alignment: .leading, spacing: ViewLayout.SWidth(10)) {
                        Text("Frequently asked question：")
                            .foregroundColor(Color.Color_333333)
                            .font(Font.S_Pro_14(.regular))
                        Text("1、Transparent background misalignment")
                            .foregroundColor(Color.Color_333333)
                            .font(Font.S_Pro_12(.regular))
                        VStack (alignment: .leading, spacing: ViewLayout.SWidth(20)) {
                            Text("Before the screenshot, please enter \"Settings\" - click on the home screen preview - turn off visual zoom - click \"Settings\"")
                                .foregroundColor(Color.Color_A5A6BF)
                                .font(Font.S_Pro_12(.regular))
                            Text("\"Click \"Select\" to upload and pull up the album. Select the picture in the album and upload it to the corresponding picture preview.")
                                .foregroundColor(Color.Color_A5A6BF)
                                .font(Font.S_Pro_12(.regular))
                        }
                    }
                    .padding(ViewLayout.SWidth(20))
                    .background(Color.Color_FFFFFF)
                    .cornerRadius(ViewLayout.SWidth(15))
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
        .navigationTitle("Transparent Widget")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.white, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isPresented = true
                }) {
                    Image("setting_question_white")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ViewLayout.SWidth(30), height: ViewLayout.SWidth(30))
                }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            TransparentDomeView()
                .background(BackgroundClearView())
        }
        .onAppear {
            selectedLightImageData = UserDefaults.standard.string(forKey: DeviceInfoUtil.getappName() + "UploadImageLightString")
            selectedDarkImageData = UserDefaults.standard.string(forKey: DeviceInfoUtil.getappName() + "UploadImageDarkString")
        }
    }
   
}



struct TransparentDomeView: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geo in
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                .overlay {
                    VStack(alignment: .center, spacing: ViewLayout.SWidth(0)) {
                        Spacer(minLength: 0)
                        VStack(alignment: .center, spacing: ViewLayout.SWidth(0)) {
                            HStack(alignment: .center, spacing: 0) {
                                Spacer(minLength: 0)
                                Image("picker_cancel")
                                    .padding(.trailing, ViewLayout.SWidth(20))
                                    .onTapGesture {
                                        dismiss()
                                    }
                            }
                        }
                        .padding([.top, .bottom], ViewLayout.SWidth(20))
                        .background(Color.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        
                        VStack (alignment: .center, spacing: ViewLayout.SWidth(20), content: {
                            // tetx
                            VStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                                Text("What is a transparent widget?")
                                    .foregroundColor(Color.Color_454545)
                                    .font(Font.S_Pro_16(.regular))
                                Text("Easily edit in a few steps to set the widget to a transparent state.")
                                    .foregroundColor(Color.Color_A5A6BF)
                                    .font(Font.S_Pro_12(.regular))
                            }
                            // 图片
                            HStack (alignment: .center, spacing: ViewLayout.SWidth(20)) {
                                VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                                    Image("setting_screen_dome_light")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("Non-transparent components")
                                        .font(Font.S_Pro_10(.regular))
                                }
                                VStack (alignment: .center, spacing: ViewLayout.SWidth(15)) {
                                    Image("setting_screen_dome_dark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    Text("transparent components")
                                        .font(Font.S_Pro_12(.regular))
                                }
                            }
                            .foregroundColor(Color.Color_454545)
                            .font(Font.S_Pro_12(.regular))
                            Button {
                                dismiss()
                            } label: {
                                Text("I Understand")
                                    .foregroundColor(Color.Color_FFFFFF)
                                    .frame(width: ViewLayout.SWidth(150), height: ViewLayout.SWidth(35))
                                    .background(Color.Color_8682FF)
                                    .cornerRadius(ViewLayout.SWidth(35) / 2)
                            }
                        })
                        .padding([.leading, .trailing], ViewLayout.SWidth(20))
                        .background(Color.white)
                    }
                }
                .onTapGesture {
                    dismiss()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
