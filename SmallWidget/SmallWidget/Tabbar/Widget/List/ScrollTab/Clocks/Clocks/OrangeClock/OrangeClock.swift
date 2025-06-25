//
//  OrangeClock.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/22.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 Orange 】============================================================
 */

// MARK: - Orange

struct ClockOrangeSmall: JRWidgetView {
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        // name
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .small)
        self.configure?.nameConfig?.viewName = "ClockOrangeSmall"
        self.configure?.nameConfig?.orialName = "Orange Clock"
        self.configure?.nameConfig?.typeName = "Orange Clock"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFF6EA).overlay(alignment: .center) {
                Image("clock_orange_small")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .overlay {
                        ClockOrangeAnimationView(configure: ClockListConfiguration(hourColor: Color.Color_AA3232, minnuteColor: Color.Color_552B08, secondColor: Color.Color_552B08), configureSize: ClockListConfigureSize(hour: 2, minute: 2, second: 2), configureScale: ClockListConfigureScale(hour: 0.08, minute: 0.12, second: 0.18))
                    }
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


/**
 ============================================================【 Animation 】============================================================
 */

// MARK: - Animation

struct ClockOrangeAnimationView: View {
    
    @State private var currentTime = Date()
    
    var configure  = ClockListConfiguration()
    var configureSize = ClockListConfigureSize()
    var configureScale = ClockListConfigureScale()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color.clear)
             
//                // 秒针
//                // 宽度为 0.4
//                // 中心位置旋转，偏移 一半。
                RoundedRectangle(cornerRadius:  configureSize.second / 2)
                    .fill(configure.secondColor)
                    .frame(width: configureSize.second, height: geometry.size.width * configureScale.second + 2 * configure.secondOff)
                    .offset(y: -geometry.size.width * (configureScale.second / 2) - configure.hourOff * 2 )
                    .swingAnimation(duration: 60, distance: 0)

                // 分针
                // 宽度为 0.3
                RoundedRectangle(cornerRadius: configure.minute / 2)
                    .fill(configure.minnuteColor)
                    .frame(width: configureSize.minute, height: geometry.size.width * configureScale.minute + 2 * configure.minute)
                    .offset(y: -geometry.size.width * (configureScale.minute / 2) - configure.hourOff * 2 )
                    .swingAnimation(duration: 60 * 60, distance: 0)

                // 时针
                // 宽度为 0.2
                RoundedRectangle(cornerRadius: configureSize.hour / 2)
                    .fill(configure.hourColor)
                    .frame(width: configureSize.hour, height: geometry.size.width * configureScale.hour + 2 * configure.hourOff)
                    .offset(y: -geometry.size.width * (configureScale.hour / 2) - configure.hourOff * 2)
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.hour, from: currentTime)) * 30))
                
                // 大中心点
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.Color_552B08)
                
                // 小中心点
                ZStack {
                    Circle().stroke(Color.clear, lineWidth: 2) // 设置空心圆
                    CircleSection(startAngle: .degrees(0), endAngle: .degrees(120 - 5))
                        .stroke(Color.Color_F29C1F, lineWidth: 2) // 设置空心圆路径颜色
                    CircleSection(startAngle: .degrees(120 + 5), endAngle: .degrees(240 - 5))
                        .stroke(Color.Color_F29C1F, lineWidth: 2)
                    CircleSection(startAngle: .degrees(240 + 5), endAngle: .degrees(360 - 5))
                        .stroke(Color.Color_F29C1F, lineWidth: 2)
                }
                .frame(width: 10, height: 10)
            }
        }
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            currentTime = Date()
        }
    }
    
}

