//
//  SnowMountainAnniversary.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/26.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 Snow Mountain 】============================================================
  当时什么日期，已经过了多少日期， 或者还有多久到那个日期
 */

// 小型
struct AnniversarySnowMountainSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.anniversary, .small)
        self.configure?.nameConfig?.viewName = "AnniversarySnowMountainSmall"
        self.configure?.nameConfig?.orialName = "Snow Mountain Memorial Day"
        self.configure?.nameConfig?.typeName = "Snow Mountain Memorial Day"
        self.configure?.itemConfig_0.text = "Anniversaries"
        self.configure?.itemConfig_0.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.isNeedBackgroudColorEdit = 0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                if configure?.backgroundImageData?.count ?? 0 > 0 {
                    AnyView(itemView(geo: geo))
                } else {
                    Image("anniversary_0_small")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay {
                            AnyView(itemView(geo: geo))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    
    func itemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack(alignment: .center) {
                Spacer(minLength: 0)
                Image("anniversary_0_small_day")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        HStack(alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).1)
                                .font(Font.S_Pro_40(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                            Text("Day")
                                .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                        }
                    }
                Text(self.configure?.itemConfig_0.text ?? String())
                    .font(Font.S_Pro_15(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                    .lineLimit(1)
                Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).0)
                    .font(Font.S_Pro_15(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
}


// 中型
struct AnniversarySnowMountainMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.anniversary, .medium)
        self.configure?.nameConfig?.viewName = "AnniversarySnowMountainMedium"
        self.configure?.nameConfig?.orialName = "Snow Mountain Memorial Day"
        self.configure?.nameConfig?.typeName = "Snow Mountain Memorial Day"
        self.configure?.itemConfig_0.text = "Anniversaries"
        self.configure?.itemConfig_0.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.isNeedBackgroudColorEdit = 0
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                if configure?.backgroundImageData?.count ?? 0 > 0 {
                    AnyView(itemView(geo: geo))
                } else {
                    Image("anniversary_0_medium")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay {
                            AnyView(itemView(geo: geo))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    
    func itemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack(alignment: .center) {
                Spacer(minLength: 0)
                Image("anniversary_0_medium_day")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        HStack(alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).1)
                                .font(Font.S_Pro_40(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                            Text("Day")
                                .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                        }
                    }
                Text(self.configure?.itemConfig_0.text ?? String())
                    .font(Font.S_Pro_15(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
                    .lineLimit(1)
                Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).0)
                    .font(Font.S_Pro_15(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_FFFFFF, .leading)
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
}
