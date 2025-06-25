//
//  CalendarMountain.swift
//  SmallWidget
//
//  Created by Q801 on 2024/8/8.
//

import Foundation
import SwiftUI
import WidgetKit



/**
 ============================================================【 Mountain  】============================================================
 */

struct CalendarMountainSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.calendar, .small)
            self.configure?.nameConfig?.viewName = "CalendarMountainSmall"
            self.configure?.nameConfig?.orialName = "Mountain Calendar"
            self.configure?.nameConfig?.typeName = "Mountain Calendar"
            self.configure?.isNeedTextColorEdit = 1
            self.configure?.isNeedBackgroudColorEdit = 1
            self.configure?.isVIP = 0
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    let tool = CalendarTool()
    
    var body: some View {
        GeometryReader { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FECCD7).overlay(alignment: .center) {
                AnyView(itemView(geo: geo))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    func itemView(geo: GeometryProxy) -> any View {
        AnyView (
            ZStack (alignment: .center, content: {
                Image("calendar_mountain_small")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .padding(SWidth(5, geo.size.height))
                    .overlay {
                        VStack (spacing: SWidth(10, geo.size.height)) {
                            HStack (alignment: .center, spacing: 0) {
                                Text("\(tool.currentWeekdayString())")
                                    .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_98A549, .leading)
                                    .font(Font.S_Pro_12(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            }
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: SWidth(0, geo.size.height)), count: 7), spacing: SWidth(0, geo.size.height)) {
                                ForEach(tool.weekdaySymbols().indices, id: \.self) { index in
                                    Text(tool.weekdaySymbols()[index])
                                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_98A549, .leading)
                                        .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                        .font(Font.S_Pro_10(.bold, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                }
                                ForEach(tool.monthLineForCurrentDate().map{DateItem(date: $0)}, id: \.id) { dateItem in
                                    let date = dateItem.date
                                    if date != Date(timeIntervalSince1970: 0) {
                                        ZStack (alignment: .center) {
                                            Text("\(tool.day(date: date))")
                                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_98A549, .leading)
                                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                                .background(tool.day(date: date) == Int(tool.currentDateFormattedDay()) ? Color.color(hexString: Color.String_Color_B0BF6E) : .clear)
                                                .cornerRadius(tool.day(date: date) == Int(tool.currentDateFormattedDay()) ? SWidth(10, geo.size.height) : 0)
                                                .font(Font.S_Pro_8(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        }
                                    } else {
                                        Text("") // 空文本，不显示内容
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                        .padding(.top, SWidth(60, geo.size.height))
                        .padding(.bottom, SWidth(30, geo.size.height))
                        .padding([.leading, .trailing], SWidth(10, geo.size.height))
                    }
            })
        )
    }
    
 
}

