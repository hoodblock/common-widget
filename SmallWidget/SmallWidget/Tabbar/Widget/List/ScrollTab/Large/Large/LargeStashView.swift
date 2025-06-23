//
//  LargeStashView.swift
//  SmallWidget
//
//  Created by nan on 2024/4/14.
//

import Foundation
import SwiftUI
import WidgetKit


/**
 ============================================================【 0 】============================================================
 */

// MARK: - 0

struct LargeStashView_0: JRWidgetView {
    
    var configure: JRWidgetConfigure?

    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.large, .large)
            self.configure?.nameConfig?.viewName = "LargeStashView_0"
            self.configure?.nameConfig?.orialName = "Gray Cycle"
            self.configure?.nameConfig?.orialName = "Gray Cycle"
            self.configure?.itemConfig_0.textColor = Color.String_Color_232220
            self.configure?.itemConfig_0.textFont = 0
            self.configure?.isNeedTextColorEdit = 1
            self.configure?.backgroundColor = Color.String_Color_E8E8E8
            self.configure?.isVIP = 1
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 310.0
    }
    
    // 一周的图片
    func imageNameFromWeekString() -> (String, String, Int) {
        if CalendarTool().currentWeekdayString() == "Monday" {
            return ("monday_icon_0", "01", 1)
        } else if CalendarTool().currentWeekdayString() == "Tuesday" {
            return ("monday_icon_1", "02", 2)
        } else if CalendarTool().currentWeekdayString() == "Wednesday" {
            return ("monday_icon_2", "03", 3)
        } else if CalendarTool().currentWeekdayString() == "Thursday" {
            return ("monday_icon_3", "04", 4)
        } else if CalendarTool().currentWeekdayString() == "Friday" {
            return ("monday_icon_4", "05", 5)
        } else {
            return ("monday_icon_5", "00", 0)
        }
    }

    func imageNameFromWeekNumber(_ weekNumber: Int) -> String {
        if weekNumber == 1 {
            return "monday_icon_0"
        } else if weekNumber == 2 {
            return "monday_icon_1"
        } else if weekNumber == 3 {
            return "monday_icon_2"
        } else if weekNumber == 4 {
            return "monday_icon_3"
        } else if weekNumber == 5 {
            return "monday_icon_4"
        } else {
            return "monday_icon_5"
        }
    }
    
    func nameFromWeekNumber(_ weekNumber: Int) -> String {
        if weekNumber == 1 {
            return "Mon"
        } else if weekNumber == 2 {
            return "Tues"
        } else if weekNumber == 3 {
            return "Wednes"
        } else if weekNumber == 4 {
            return "Thurs"
        } else if weekNumber == 5 {
            return "Fri"
        } else {
            return "Week"
        }
    }
    
    func numberFromWeekNumber(_ weekNumber: Int) -> String {
        if weekNumber == 1 {
            return "01"
        } else if weekNumber == 2 {
            return "02"
        } else if weekNumber == 3 {
            return "03"
        } else if weekNumber == 4 {
            return "04"
        } else if weekNumber == 5 {
            return "05"
        } else {
            return "00"
        }
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                HStack (alignment: .center, spacing: SWidth(0, geo.size.height)) {
                    Spacer()
                    VStack (alignment: .center, spacing: SWidth(20, geo.size.height)) {
                        //
                        HStack (alignment: .center, spacing: SWidth(20, geo.size.height)) {
                            VStack (alignment: .center, spacing: SWidth(0, geo.size.height)) {
                                Spacer()
                                // 上- 时间
                                HStack (alignment: .center, spacing: SWidth(0, geo.size.height)) {
                                    Spacer()
                                    Text(CalendarTool.getCurrentDayStart(), style: .timer)
                                        .monospacedDigit()
                                        .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                        .multilineTextAlignment(.center)
                                    Spacer()
                                }
                                .padding([.top, .bottom], SWidth(10, geo.size.height))
                                .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                                .cornerRadius(SWidth(10, geo.size.height))
                                .shadow(color: Color.Color_D8D7D7, radius: 2)
                                Spacer()
                                // 下 - 日期 / 图
                                HStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                                    VStack (alignment: .leading, spacing: SWidth(5, geo.size.height)) {
                                        Text("\(CalendarTool().currentDateFormattedYear())-\(CalendarTool().currentDateFormattedMonth())-\(CalendarTool().currentDateFormattedDay())")
                                        Text("\(CalendarTool().currentWeekdayString())")
                                    }
                                    .font(Font.S_Pro_6(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                    .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                    Spacer()
                                    Image(self.imageNameFromWeekString().0)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(50, geo.size.height), height: SWidth(50, geo.size.height))
                                }
                                Spacer()
                            }
                            .padding([.leading, .trailing], SWidth(10, geo.size.height))
                            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                            .cornerRadius(SWidth(10, geo.size.height))
                            .shadow(color: Color.Color_D8D7D7, radius: 2)
                            
                            VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                // 时间
                                VStack (alignment: .center) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.Color_E1DFE0)
                                            .overlay {
                                                CircleSection(startAngle: .degrees(CalendarTool.scrollCurrentTimeFromStartDayTime().0), endAngle: .degrees(CalendarTool.scrollCurrentTimeFromStartDayTime().1))
                                                    .stroke(Color.red, lineWidth: SWidth(3, geo.size.height))
                                                    .padding(SWidth(2, geo.size.height))
                                                    .overlay {
                                                        Circle()
                                                            .fill(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                                                            .padding(SWidth(5, geo.size.height))
                                                            .overlay {
                                                               Text(CalendarTool.scrollCurrentTimeFromStartDayTime().2)
                                                                    .font(Font.S_Pro_4(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                            }
                                                    }
                                              
                                                }
                                    }
                                    .padding(.top, SWidth(5, geo.size.height))

                                    VStack() {
                                        Text("To Day")
                                    }
                                    .font(Font.S_Pro_4(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                }
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_454A4D, .leading)
                                .padding([.leading, .trailing], SWidth(2, geo.size.height))
                                
                                // 时间
                                VStack (alignment: .center) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.Color_E1DFE0)
                                            .overlay {
                                                CircleSection(startAngle: .degrees(CalendarTool.scrollCurrentTimeFromStartYearTime().0), endAngle: .degrees(CalendarTool.scrollCurrentTimeFromStartYearTime().1))
                                                    .stroke(Color.black, lineWidth: SWidth(3, geo.size.height))
                                                    .padding(SWidth(2, geo.size.height))
                                                    .overlay {
                                                        Circle()
                                                            .fill(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                                                            .padding(SWidth(5, geo.size.height))
                                                            .overlay {
                                                                Text(CalendarTool.scrollCurrentTimeFromStartYearTime().2)
                                                                    .font(Font.S_Pro_4(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                            }
                                                    }
                                              
                                                }
                                    }
                                    .padding(.top, SWidth(5, geo.size.height))

                                    VStack() {
                                        Text("To Year")
                                    }
                                    .font(Font.S_Pro_4(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                }
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_454A4D, .leading)
                                .padding([.leading, .trailing], SWidth(2, geo.size.height))
                                
                            }
                            .padding([.leading, .trailing], SWidth(10, geo.size.height))
                            .padding([.top, .bottom], SWidth(5, geo.size.height))
                            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                            .cornerRadius(SWidth(10, geo.size.height))
                            .shadow(color: Color.Color_CACACA, radius: 2)
                        }
                        
                        // 下
                        VStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                            // 状态
                            HStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                                HStack (alignment: .center, spacing: SWidth(0, geo.size.height)) {
                                    Text("Week Status")
                                        .font(Font.S_Pro_6(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                                .frame(width: SWidth(100, geo.size.height), height: SWidth(20, geo.size.height))
                                .padding([.leading, .trailing], SWidth(5, geo.size.height))
                                .padding([.top, .bottom], SWidth(5, geo.size.height))
                                .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                                .cornerRadius(SWidth(10, geo.size.height))
                                .shadow(color: Color.Color_D8D7D7, radius: 2)
                                Spacer()
                                Circle()
                                    .fill(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                                    .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    .overlay {
                                        Text(self.imageNameFromWeekString().1)
                                            .font(Font.S_Pro_6(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                            .foregroundColor(Color.color(hexString: Color.String_Color_FF5678))
                                    }
                                    .shadow(color: Color.Color_D8D7D7, radius: 2)
                            }
                            // week 图片
                            HStack (alignment: .center, spacing: SWidth(0, geo.size.height)) {
                                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Image(self.imageNameFromWeekNumber(1))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    ZStack (alignment: .center) {
                                        GeometryReader { geometry in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: geometry.size.height / 2)) // 设置线的起始点
                                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2)) // 设置线的结束点
                                            }
                                            .stroke(Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3), lineWidth: 1)
                                            .frame(height: 1)
                                            Circle()
                                                .fill(self.imageNameFromWeekString().2 == 1 ? Color.Color_FF5678 : Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3))
                                                .frame(width: 3, height: 3)
                                                .offset(x: geometry.size.width / 2, y: 1)
                                        }
                                    }
                                    .frame(maxHeight: SWidth(5, geo.size.height))
                                    Text(self.nameFromWeekNumber(1))
                                        .gradientForeColor(self.imageNameFromWeekString().2 == 1 ? Color.String_Color_FF5678 : configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Image(self.imageNameFromWeekNumber(2))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    ZStack (alignment: .center) {
                                        GeometryReader { geometry in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: geometry.size.height / 2)) // 设置线的起始点
                                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2)) // 设置线的结束点
                                            }
                                            .stroke(Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3), lineWidth: 1)
                                            .frame(height: 1)
                                            Circle()
                                                .fill(self.imageNameFromWeekString().2 == 2 ? Color.Color_FF5678 : Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3))
                                                .frame(width: 3, height: 3)
                                                .offset(x: geometry.size.width / 2, y: 1)
                                        }
                                    }
                                    .frame(maxHeight: SWidth(5, geo.size.height))
                                    Text(self.nameFromWeekNumber(2))
                                        .gradientForeColor(self.imageNameFromWeekString().2 == 2 ? Color.String_Color_FF5678 : configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Image(self.imageNameFromWeekNumber(3))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    ZStack (alignment: .center) {
                                        GeometryReader { geometry in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: geometry.size.height / 2)) // 设置线的起始点
                                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2)) // 设置线的结束点
                                            }
                                            .stroke(Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3), lineWidth: 1)
                                            .frame(height: 1)
                                            Circle()
                                                .fill(self.imageNameFromWeekString().2 == 3 ? Color.Color_FF5678 : Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3))
                                                .frame(width: 3, height: 3)
                                                .offset(x: geometry.size.width / 2, y: 1)
                                        }
                                    }
                                    .frame(maxHeight: SWidth(5, geo.size.height))
                                    Text(self.nameFromWeekNumber(3))
                                        .gradientForeColor(self.imageNameFromWeekString().2 == 3 ? Color.String_Color_FF5678 : configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Image(self.imageNameFromWeekNumber(4))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    ZStack (alignment: .center) {
                                        GeometryReader { geometry in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: geometry.size.height / 2)) // 设置线的起始点
                                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2)) // 设置线的结束点
                                            }
                                            .stroke(Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3), lineWidth: 1)
                                            .frame(height: 1)
                                            Circle()
                                                .fill(self.imageNameFromWeekString().2 == 4 ? Color.Color_FF5678 : Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3))
                                                .frame(width: 3, height: 3)
                                                .offset(x: geometry.size.width / 2, y: 1)
                                        }
                                    }
                                    .frame(maxHeight: SWidth(5, geo.size.height))
                                    Text(self.nameFromWeekNumber(4))
                                        .gradientForeColor(self.imageNameFromWeekString().2 == 4 ? Color.String_Color_FF5678 : configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Image(self.imageNameFromWeekNumber(5))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                    ZStack (alignment: .center) {
                                        GeometryReader { geometry in
                                            Path { path in
                                                path.move(to: CGPoint(x: 0, y: geometry.size.height / 2)) // 设置线的起始点
                                                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height / 2)) // 设置线的结束点
                                            }
                                            .stroke(Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3), lineWidth: 1)
                                            .frame(height: 1)
                                            Circle()
                                                .fill(self.imageNameFromWeekString().2 == 5 ? Color.Color_FF5678 : Color.color(hexString: configure?.itemConfig_0.textColor ?? Color.String_Color_232220).opacity(0.3))
                                                .frame(width: 3, height: 3)
                                                .offset(x: geometry.size.width / 2, y: 1)
                                        }
                                    }
                                    .frame(maxHeight: SWidth(5, geo.size.height))
                                    Text(self.nameFromWeekNumber(5))
                                        .gradientForeColor(self.imageNameFromWeekString().2 == 5 ? Color.String_Color_FF5678 : configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                                }
                            }
                            .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_232220, .leading)
                            .font(Font.S_Pro_5(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                        .padding([.leading, .trailing], SWidth(10, geo.size.height))
                        .padding([.top, .bottom], SWidth(10, geo.size.height))
                        .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_E9E7E8))
                        .cornerRadius(SWidth(10, geo.size.height))
                        .shadow(color: Color.Color_CACACA, radius: 2)
                    }
                    Spacer()
                }
                .padding([.top, .bottom], SWidth(20, geo.size.height))
                .padding([.leading, .trailing], SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
