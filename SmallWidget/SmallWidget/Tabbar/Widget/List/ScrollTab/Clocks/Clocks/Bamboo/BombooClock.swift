//
//  BombooClock.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/5.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 Bomboo 】============================================================
 */


// MARK: - Bomboo

struct ClockBombooSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        // name
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .small)
        self.configure?.nameConfig?.viewName = "ClockBombooSmall"
        self.configure?.nameConfig?.orialName = "Bomboo Clock"
        self.configure?.nameConfig?.typeName = "Bomboo Clock"
        self.configure?.isNeedTextColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E6D594).overlay(alignment: .center) {
                ZStack(alignment: .center) {
                    Image("clock_bamboo_small")
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .offset(x: SWidth(0, geo.size.height), y : SWidth(0, geo.size.height))
                    AnyView(starrySkyItemView(geo: geo))
                        .overlay {
                            ClockBambooAnimationView(configure: ClockListConfiguration(hourColor: Color.Color_42933A, minnuteColor: Color.Color_42933A), configureSize: ClockListConfigureSize(hour: 2, minute: 2), configureScale: ClockListConfigureScale(hour: 0.1, minute: 0.15))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func starrySkyItemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack (alignment: .center, spacing: 0) {
                Spacer()
                HStack (alignment: .center, spacing: 0) {
                    Spacer()
                    ZStack(alignment: .center) {
                        ForEach(1..<13) { hour in
                            // 取每份弧度，然后再逆时针旋转 固定三个弧度，
                            let angle = 2.0 * .pi / 12.0 * Double(hour) - (2.0 * .pi / 12.0 * Double(3))
                            let x = SWidth(50, geo.size.height) * cos(angle)
                            let y = SWidth(50, geo.size.height) * sin(angle)
                            Text("\(hour)")
                                .position(x: SWidth(50, geo.size.height) + x, y: SWidth(50, geo.size.height) + y)
                                .font(Font.S_Pro_10(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_6EA136, .leading)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
    
}


//
struct ClockBombooMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        // name
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .medium)
        self.configure?.nameConfig?.viewName = "ClockBombooMedium"
        self.configure?.nameConfig?.orialName = "Bomboo Clock"
        self.configure?.nameConfig?.typeName = "Bomboo Clock"
        self.configure?.isNeedTextColorEdit = 1

    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    let calendarTool = CalendarTool()
    
    
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    static let minuteFormatter: DateFormatter = {
        let fomatter = DateFormatter()
        fomatter.dateFormat = "mm"
        return fomatter
    }()
    
    let rateTextData = "\(CalendarTool().currentDateFormattedYear()).\(CalendarTool().currentDateFormattedMonth()).\(CalendarTool().currentDateFormattedDay())"
    let mineteData = CalendarTool.showCurrentTimehsString(false)

    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E6D594).overlay(alignment: .center) {
                VStack (alignment: .center, spacing: 0) {
                    HStack (alignment: .center, spacing: 0) {
                        // 时钟
                        ZStack(alignment: .center) {
                            Image("clock_bamboo_small")
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .offset(x: SWidth(0, geo.size.height), y : SWidth(0, geo.size.height))
                            AnyView(starrySkyItemView(geo: geo))
                                .overlay {
                                    ClockBambooAnimationView(configure: ClockListConfiguration(hourColor: Color.Color_42933A, minnuteColor: Color.Color_42933A), configureSize: ClockListConfigureSize(hour: 2, minute: 2), configureScale: ClockListConfigureScale(hour: 0.1, minute: 0.15))
                                }
                        }

                        // 表盘
                        Image("clock_bamboo_medium")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: SWidth(180, geo.size.height), height: SWidth(125, geo.size.height), alignment: .center)
                            .overlay {
                                VStack (alignment: .center) {
                                    Text("\(Self.hourFormatter.string(from: Date()))" + ":" + "\(Self.minuteFormatter.string(from: Date()))")
                                        .font(Font.S_Pro_30(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                    Text(calendarTool.currentDateFormattedYear() + "." + calendarTool.currentDateFormattedMonth() + "." + calendarTool.currentDateFormattedDay())
                                        .font(Font.S_Pro_13(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                }
                                .padding(SWidth(20, geo.size.height))
                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_6EA136, .leading)
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    func starrySkyItemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack (alignment: .center, spacing: 0) {
                Spacer()
                HStack (alignment: .center, spacing: 0) {
                    Spacer()
                    ZStack(alignment: .center) {
                        ForEach(1..<13) { hour in
                            // 取每份弧度，然后再逆时针旋转 固定三个弧度，
                            let angle = 2.0 * .pi / 12.0 * Double(hour) - (2.0 * .pi / 12.0 * Double(3))
                            let x = SWidth(50, geo.size.height) * cos(angle)
                            let y = SWidth(50, geo.size.height) * sin(angle)
                            Text("\(hour)")
                                .position(x: SWidth(50, geo.size.height) + x, y: SWidth(50, geo.size.height) + y)
                                .font(Font.S_Pro_10(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_6EA136, .leading)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
}




struct ClockBambooAnimationView: View {
    
    @State private var currentTime = Date()
    
    var configure  = ClockListConfiguration()
    var configureSize = ClockListConfigureSize()
    var configureScale = ClockListConfigureScale()
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .foregroundColor(Color.clear)
//                // 秒针
//                // 宽度为 0.4
//                // 中心位置旋转，偏移 一半。
//                RoundedRectangle(cornerRadius:  configureSize.second / 2)
//                    .fill(configure.clear)
//                    .frame(width: configureSize.second, height: geometry.size.width * configureScale.second + 2 * configure.secondOff)
//                    .offset(y: -SWidth(22, geometry.size.height))
//                    .swingAnimation(duration: 1, direction: .horizontal, distance: 0)

                // 分针
                // 宽度为 0.3
                RoundedRectangle(cornerRadius: configure.minute / 2)
                    .fill(configure.minnuteColor)
                    .frame(width: configureSize.minute, height: geometry.size.width * configureScale.minute + 2 * configure.minute)
                    .offset(y: -SWidth(15, geometry.size.height))
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) * 6))

                // 时针
                // 宽度为 0.2
                RoundedRectangle(cornerRadius: configureSize.hour / 2)
                    .fill(configure.hourColor)
                    .frame(width: configureSize.hour, height: geometry.size.width * configureScale.hour + 2 * configure.hourOff)
                    .offset(y: -SWidth(8, geometry.size.height))
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.hour, from: currentTime)) * 30))
                
                // 大中心点
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(Color.Color_42933A)
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

