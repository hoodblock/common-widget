//
//  CalendarSolidColor.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/27.
//

import SwiftUI
import WidgetKit

/**
 ============================================================【 Solid  】============================================================
 */


struct CalendarSolidColorMeidum: JRWidgetView  {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
                
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.calendar, .medium)
            
            self.configure?.nameConfig?.viewName = "CalendarSolidColorMeidum"
            self.configure?.nameConfig?.orialName = "Solid Calendar"
            self.configure?.nameConfig?.typeName = "Solid Calendar"
            self.configure?.isNeedTextColorEdit = 1
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
        
    let tool = CalendarTool()
    
    var body: some View {
        GeometryReader { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_6FB28C).overlay(alignment: .center) {
                AnyView(solidColorItemView(geo: geo))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_6FB28C))
        }
    }
    
    
    func solidColorItemView(geo: GeometryProxy) -> any View {
        AnyView (
            VStack (alignment: .center) {
                Spacer(minLength: 0)
                HStack (alignment: .center, spacing: SWidth(5)) {
                    HStack (alignment: .center) {
                        Spacer(minLength: 0)
                        VStack (alignment: .center, spacing: SWidth(3)) {
                            Text("\(tool.currentDateFormattedYear()) - \(tool.currentDateFormattedMonth())")
                                .font(Font.S_Pro_14(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("\(tool.currentDateFormattedDay())")
                                .font(Font.S_Pro_40(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("\(tool.currentWeekdayString())")
                                .font(Font.S_Pro_14(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("Day \(tool.dayOfYear()) Week \(tool.weekOfYear())")
                                .font(Font.S_Pro_14(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                        Spacer(minLength: 0)
                    }
                    .offset(x: -SWidth(10, geo.size.height))
                    HStack (alignment: .center, spacing: 0) {
                        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: SWidth(10, geo.size.height)), count: 7), spacing: SWidth(0, geo.size.height)) {
                            ForEach(tool.weekdaySymbols().indices, id: \.self) { index in
                                Text(tool.weekdaySymbols()[index])
                                    .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                    .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                    .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                                    .minimumScaleFactor(0.8)
                            }
                            ForEach(tool.monthDates().map{DateItem(date: $0)}, id: \.id) { dateItem in
                                let date = dateItem.date
                                if date != Date(timeIntervalSince1970: 0) {
                                    Text("\(tool.day(date: date))")
                                        .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                        .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                                        .background( tool.day(date: date) == Int(tool.currentDateFormattedDay()) ? Color.Color_DFDEDE.opacity(0.4) : Color.clear)
                                        .cornerRadius(tool.day(date: date) == Int(tool.currentDateFormattedDay()) ? SWidth(10, geo.size.height) : 0)
                                        .minimumScaleFactor(0.8)
                                } else {
                                    Text("") // 空文本，不显示内容
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
    
}

