//
//  AnimationClock.swift
//  SmallWidget
//
//  Created by nan on 2025/6/25.
//

import SwiftUI
import WidgetKit

// MARK: - Animation

struct ClockAnimationSmall: JRWidgetView {
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .small)
        self.configure?.nameConfig?.viewName = "ClockAnimationSmall"
        self.configure?.nameConfig?.orialName = "Animation Clock"
        self.configure?.nameConfig?.typeName = "Animation Clock"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFF6EA).overlay(alignment: .center) {
               Text("Hello")
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(
                        AnimatedArcGIFView(gifName: "animation_0", defaultImageName: "", maxFrameCount: 30)
                    )
                    .background(.black)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



struct ClockAnimationMedium: JRWidgetView {
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .medium)
        self.configure?.nameConfig?.viewName = "ClockAnimationMedium"
        self.configure?.nameConfig?.orialName = "Animation Clock"
        self.configure?.nameConfig?.typeName = "Animation Clock"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFF6EA).overlay(alignment: .center) {
                HStack () {
                    Spacer()
                    Text("Hello")
                        .foregroundColor(.blue)
                        .swingAnimation(arm1Length: 40, arm2Length: 40, duration1: -10, duration2: 5, direction: .horizontal)
                    Text("Word")
                        .foregroundColor(.blue)
                        .swingAnimation(arm1Length: 40, arm2Length: 40, duration1: -10, duration2: 5, direction: .vertical)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



