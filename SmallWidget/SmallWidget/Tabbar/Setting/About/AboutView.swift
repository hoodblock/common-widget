//
//  AboutView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/8.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var lightModel: Bool = false

    
    var body: some View {
        VStack (alignment:.center, spacing: ViewLayout.SWidth(20)) {
            Spacer(minLength: 0)
            Image("settingimage")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 70, height: 70)
            Text(DeviceInfoUtil.getappName())
                .font(.S_Pro_15())
                .foregroundColor(Color.Color_333333)
            Text("Version :" + DeviceInfoUtil.getappSVersion())
                .font(.S_Pro_13())
                .foregroundColor(Color.appVersion)
            Spacer(minLength: 0)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .navigationTitle("About US")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.Color_F6F6F6)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(viewBlock: {
            withAnimation(nil) {
                presentationMode.wrappedValue.dismiss()
            }
        }, lightModel: $lightModel))
        .toolbarBackground(.white, for: .navigationBar)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
