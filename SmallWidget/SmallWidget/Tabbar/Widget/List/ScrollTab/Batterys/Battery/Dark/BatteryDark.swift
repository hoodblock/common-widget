//
//  BatteryDark.swift
//  SmallWidget
//
//  Created by Thomas on 2025/3/21.
//

import Foundation
import SwiftUI
import WidgetKit

struct BatteryDarkSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.battery, .small)
        self.configure?.nameConfig?.viewName = "BatteryDarkSmall"
        self.configure?.nameConfig?.orialName = "Dark"
        self.configure?.nameConfig?.typeName = "Dark"
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 1
        self.configure?.isVIP = 0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_000000).overlay(alignment: .center) {
                VStack () {
                    Circle()
                        .stroke(Color.Color_FFFFFF.opacity(0.3), lineWidth: SWidth(3, geo.size.height))
                        .overlay {
                            Circle()
                                .stroke(Color.Color_FFFFFF.opacity(0.6), lineWidth: SWidth(6, geo.size.height))
                                .overlay(content: {
                                    CircleSection(startAngle: .degrees(UIDevice().getBatteryRatio().0), endAngle: .degrees(UIDevice().getBatteryRatio().1))
                                        .stroke(Color.Color_FFFFFF, lineWidth: SWidth(8, geo.size.height))
                                        .overlay {
                                            VStack () {
                                                Text("\(BatteryNumber.battery())%")
                                                    .font(Font.S_Pro_13(.bold, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                    .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                                                Text("Power")
                                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                    .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                                            }
                                        }
                                })
                                .padding()
                        }
                }
                .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



