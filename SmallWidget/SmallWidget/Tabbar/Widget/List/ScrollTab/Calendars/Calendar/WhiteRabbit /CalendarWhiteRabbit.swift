//
//  CalendarWhiteRabbit.swift
//  SmallWidget
//
//  Created by Thomas on 2024/10/24.
//


import SwiftUI
import WidgetKit


/**
 ============================================================【 White Rabbit  】============================================================
 */

struct CalendarWhiteRabbitSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.calendar, .small)
            self.configure?.nameConfig?.viewName = "CalendarWhiteRabbitSmall"
            self.configure?.nameConfig?.orialName = "White Rabbit Calendar"
            self.configure?.nameConfig?.typeName = "White Rabbit Calendar"
            self.configure?.isNeedTextColorEdit = 1
            self.configure?.isNeedBackgroudColorEdit = 0
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    let tool = CalendarTool()
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                if configure?.backgroundImageData?.count ?? 0 > 0 {
                    AnyView(starrySkyItemView(geo: geo))
                } else {
                    Image("calendar_whiterabbit_small")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .overlay {
                            AnyView(starrySkyItemView(geo: geo))
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    
    func starrySkyItemView(geo: GeometryProxy) -> any View {
        AnyView(
            HStack (alignment: .center) {
                Spacer(minLength: 0)
                VStack (alignment: .center, spacing: SWidth(2, geo.size.height)) {
                    Spacer()
                    Text("\(tool.currentDateFormattedYear()) - \(tool.currentDateFormattedMonth())")
                        .font(Font.S_Pro_14(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    Text("\(tool.currentDateFormattedDay())")
                        .font(Font.S_Pro_35(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    Text("\(tool.currentWeekdayString())")
                        .font(Font.S_Pro_14(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    Spacer()
                }
                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_D75B16, .leading)
                Spacer(minLength: 0)
            }
        )
    }
    
}
