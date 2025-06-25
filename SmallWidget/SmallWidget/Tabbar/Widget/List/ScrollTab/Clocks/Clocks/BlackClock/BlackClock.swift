//
//  BlackClock.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/5.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 Black 】============================================================
 */


// MARK: - Black

struct ClockBlackMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?

    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        // name
        self.configure = WidgetViewConfig.widgetViewConfig(.clock, .medium)
        self.configure?.nameConfig?.viewName = "ClockBlackMedium"
        self.configure?.nameConfig?.orialName = "Black Clock"
        self.configure?.nameConfig?.typeName = "Black Clock"
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
    
    var body: some View {
        GeometryReader(content: { geometry in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_1B1B1F).overlay(alignment: .center) {
                Image("clock_technology_medium")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        VStack (alignment: .center, spacing: SWidth(3, geometry.size.height)) {
                            HStack (alignment: .center) {
                                Text(CalendarTool.getCurrentDayStart(), style: .timer)
                                    .multilineTextAlignment(.center)
                                    .monospacedDigit()
                            }
                            .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_3CB8DA, .leading)
                            .font(Font.S_Pro_40(.medium, geometry.size.height, (configure?.itemConfig_0.textFont)!))
                            HStack (alignment: .center, spacing: SWidth(5, geometry.size.height)) {
                                Text(calendarTool.currentDateFormattedYear() + "-" + calendarTool.currentDateFormattedMonth() + "-" + calendarTool.currentDateFormattedDay())
                                Text(calendarTool.currentWeekdayString())
                            }
                            .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_AAD7E3, .leading)
                            .font(Font.S_Pro_10(.regular, geometry.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                    }
                    .padding(SWidth(10, geometry.size.height))
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

struct ClockBlackAnimationView: View {
    @State private var currentTime = Date()
    
    var configure  = ClockListConfiguration()
    var configureSize = ClockListConfigureSize()
    var configureScale = ClockListConfigureScale()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .fill(Color.clear)
                // 秒针
                // 宽度为 0.4
                // 中心位置旋转，偏移 一半。
                RoundedRectangle(cornerRadius:  configureSize.second / 2)
                    .fill(configure.secondColor)
                    .frame(width: configureSize.second, height: geometry.size.width * configureScale.second + 2 * configure.secondOff)
                    .offset(y: -geometry.size.width * (configureScale.second / 2))
                
                // 分针
                // 宽度为 0.3
                RoundedRectangle(cornerRadius: configure.minute / 2)
                    .fill(configure.minnuteColor)
                    .frame(width: configureSize.minute, height: geometry.size.width * configureScale.minute + 2 * configure.minute)
                    .offset(y: -geometry.size.width * (configureScale.minute / 2))
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.minute, from: currentTime)) * 6))
                
                // 时针
                // 宽度为 0.2
                RoundedRectangle(cornerRadius: configureSize.hour / 2)
                    .fill(configure.hourColor)
                    .frame(width: configureSize.hour, height: geometry.size.width * configureScale.hour + 2 * configure.hourOff)
                    .offset(y: -geometry.size.width * (configureScale.hour / 2))
                    .rotationEffect(Angle.degrees(Double(Calendar.current.component(.hour, from: currentTime)) * 30))
                
                // 中心点
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.black)
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
