//
//  EventAnniversary.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/26.
//

import SwiftUI
import WidgetKit




/**
 ============================================================【 Event  】============================================================
  当时什么日期，已经过了多少日期， 或者还有多久到那个日期
 */

struct AnniversaryEventsSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.anniversary, .small)
        self.configure?.nameConfig?.viewName = "AnniversaryEventsSmall"
        self.configure?.nameConfig?.orialName = "Event Day"
        self.configure?.nameConfig?.typeName = "Event Day"
        self.configure?.itemConfig_0.text = "CHRISTMAS"
        self.configure?.itemConfig_0.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.itemConfig_1.text = "PAY OFF"
        self.configure?.itemConfig_1.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.itemConfig_2.text = "BIRTHDAY"
        self.configure?.itemConfig_2.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.isNeedItemEditCount = 3
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
                    Image("anniversary_2_small")
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
            VStack(alignment: .center, spacing: SWidth(2, geo.size.height)) {
                // 上
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: SWidth(5, geo.size.height)) {
                        Text((self.configure?.itemConfig_0.text)!)
                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).0)
                            .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)
                    }
                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).1)
                                .font(Font.S_Pro_20(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                    }
                }
                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_82704F, .leading)

                Rectangle()
                    .fill(Color.white)
                    .frame(height: SWidth(0.5, geo.size.height))
                    .padding([.leading, .trailing], SWidth(10, geo.size.height))

                // 中间
                HStack(alignment: .center) {
                    VStack (alignment: .leading, spacing: SWidth(5, geo.size.height)) {
                        Text((self.configure?.itemConfig_1.text)!)
                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_1.textLoop)!, dateString: (self.configure?.itemConfig_1.textDate)!).0)
                            .gradientForeColor(configure?.itemConfig_1.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)
                            .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    }

                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_1.textLoop)!, dateString: (self.configure?.itemConfig_1.textDate)!).1)
                                .font(Font.S_Pro_20(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                    }
                }
                .gradientForeColor(configure?.itemConfig_1.textColor ?? Color.String_Color_82704F, .leading)

                Rectangle()
                    .fill(Color.white)
                    .frame(height: SWidth(0.5, geo.size.height))
                    .padding([.leading, .trailing], SWidth(10, geo.size.height))

                // 底部
                HStack(alignment: .center) {
                    VStack (alignment: .leading, spacing: SWidth(5)) {
                        Text((self.configure?.itemConfig_2.text)!)
                            .gradientForeColor(configure?.itemConfig_2.textColor ?? Color.String_Color_82704F, .leading)

                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_2.textLoop)!, dateString: (self.configure?.itemConfig_2.textDate)!).0)
                            .gradientForeColor(configure?.itemConfig_2.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)
                            .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    }

                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_2.textLoop)!, dateString: (self.configure?.itemConfig_2.textDate)!).1)
                                .font(Font.S_Pro_20(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_12(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                    }
                }
                .gradientForeColor(configure?.itemConfig_2.textColor ?? Color.String_Color_82704F, .leading)
            }
            .padding(SWidth(10, geo.size.height))
        )
    }
}



//
struct AnniversaryEventsMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.anniversary, .medium)
        self.configure?.nameConfig?.viewName = "AnniversaryEventsMedium"
        self.configure?.nameConfig?.orialName = "Event Day"
        self.configure?.nameConfig?.typeName = "Event Day"
        self.configure?.itemConfig_0.text = "CHRISTMAS"
        self.configure?.itemConfig_0.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.itemConfig_1.text = "PAY OFF"
        self.configure?.itemConfig_1.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.itemConfig_2.text = "BIRTHDAY"
        self.configure?.itemConfig_2.textDate = String(CalendarTool.currentYear()) + "-" + String(CalendarTool.currentMonth()) + "-" + String(CalendarTool.currentDay())
        self.configure?.isNeedBackgroudColorEdit = 0
        self.configure?.isNeedItemEditCount = 3
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
                    Image("anniversary_2_medium")
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
            VStack(alignment: .center, spacing: SWidth(2, geo.size.height)) {
                // 上
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: SWidth(5, geo.size.height)) {
                        Text((self.configure?.itemConfig_0.text)!)
                            .font(Font.S_Pro_16(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).0)
                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)

                    }
                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_0.textLoop)!, dateString: (self.configure?.itemConfig_0.textDate)!).1)
                                .font(Font.S_Pro_25(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                    }
                    Spacer()
                }
                .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_82704F, .leading)

                
                Rectangle()
                    .fill(Color.white)
                    .frame(height: SWidth(0.5, geo.size.height))
                    .padding([.leading, .trailing], SWidth(10, geo.size.height))

                // 中间
                HStack(alignment: .center) {
                    Spacer()
                    VStack (alignment: .leading, spacing: SWidth(5, geo.size.height)) {
                        Text((self.configure?.itemConfig_1.text)!)
                            .font(Font.S_Pro_16(.medium, geo.size.height, (configure?.itemConfig_1.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_1.textLoop)!, dateString: (self.configure?.itemConfig_1.textDate)!).0)
                            .gradientForeColor(configure?.itemConfig_1.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)
                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_1.textFont)!))
                    }

                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_1.textLoop)!, dateString: (self.configure?.itemConfig_1.textDate)!).1)
                                .font(Font.S_Pro_25(.medium, geo.size.height, (configure?.itemConfig_1.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_1.textFont)!))
                        }
                    }
                    Spacer()
                }
                .gradientForeColor(configure?.itemConfig_1.textColor ?? Color.String_Color_82704F, .leading)


                Rectangle()
                    .fill(Color.white)
                    .frame(height: SWidth(0.5, geo.size.height))
                    .padding([.leading, .trailing], SWidth(10, geo.size.height))

                // 底部
                HStack(alignment: .center) {
                    Spacer()
                    VStack (alignment: .leading, spacing: SWidth(5)) {
                        Text((self.configure?.itemConfig_2.text)!)
                            .font(Font.S_Pro_16(.medium, geo.size.height, (configure?.itemConfig_2.textFont)!))
                            .lineLimit(1)
                        Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_2.textLoop)!, dateString: (self.configure?.itemConfig_2.textDate)!).0)
                            .gradientForeColor(configure?.itemConfig_2.textColor ?? Color.String_Color_82704F, .leading).opacity(0.6)
                            .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_2.textFont)!))
                    }

                    Spacer(minLength: 0)
                    VStack(alignment: .trailing) {
                        HStack (alignment: .center) {
                            Text(CalendarTool.dateLoop(fromIndex: (configure?.itemConfig_2.textLoop)!, dateString: (self.configure?.itemConfig_2.textDate)!).1)
                                .font(Font.S_Pro_25(.medium, geo.size.height, (configure?.itemConfig_2.textFont)!))
                            Text("Day")
                                .font(Font.S_Pro_14(.medium, geo.size.height, (configure?.itemConfig_2.textFont)!))
                        }
                    }
                }
                .gradientForeColor(configure?.itemConfig_2.textColor ?? Color.String_Color_82704F, .leading)
            }
            .padding(SWidth(20, geo.size.height))
        )
    }
}
