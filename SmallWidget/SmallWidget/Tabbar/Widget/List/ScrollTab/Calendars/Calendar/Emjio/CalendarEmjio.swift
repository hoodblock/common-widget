//
//  CalendarEmjio.swift
//  SmallWidget
//
//  Created by Q801 on 2024/8/8.
//

import Foundation
import SwiftUI
import WidgetKit


struct CalendarEmjioMeidum: JRWidgetView  {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
                
        if !((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            self.configure = WidgetViewConfig.widgetViewConfig(.calendar, .medium)
            self.configure?.nameConfig?.viewName = "CalendarEmjioMeidum"
            self.configure?.nameConfig?.orialName = "Emjio Calendar"
            self.configure?.nameConfig?.typeName = "Emjio Calendar"
            self.configure?.isNeedTextColorEdit = 1
            self.configure?.isNeedBackgroudColorEdit = 1
            self.configure?.isVIP = 1
        }
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
        
    func monthNumberToString(_ number: Int) -> String {
         switch number {
         case 1:
             "January"
         case 2:
             "February"
         case 3:
             "March"
         case 4:
             "April"
         case 5:
             "May"
         case 6:
             "June"
         case 7:
             "July"
         case 8:
             "August"
         case 9:
             "September"
         case 10:
             "October"
         case 11:
             "November"
         case 12:
             "December"
         default:
             "January"
         }
     }
    
    let tool = CalendarTool()
    
    var body: some View {
        GeometryReader { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_5B8C9B).overlay(alignment: .center) {
                AnyView(itemView(geo: geo))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF))
        }
    }
    
    func weekdayEmjioSymbols() -> [String] {
       return ["calendar_emjio_medium_0",
               "calendar_emjio_medium_1",
               "calendar_emjio_medium_2",
               "calendar_emjio_medium_3",
               "calendar_emjio_medium_4",
               "calendar_emjio_medium_5",
               "calendar_emjio_medium_6",
       ]
    }
    
        
    func itemView(geo: GeometryProxy) -> any View {
        AnyView (
            ZStack (alignment: .center, content: {
                HStack () {
                    VStack (spacing: SWidth(5, geo.size.height)) {
                        HStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                            Text("\(tool.currentDateFormattedDay())")
                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_7FA0FF, .leading)
                                .font(Font.S_Pro_30(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("\(tool.currentWeekdayString())")
                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_7C7B88, .leading)
                                .font(Font.S_Pro_15(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Spacer()
                        }
                        VStack (spacing: SWidth(5, geo.size.height)) {
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: SWidth(0, geo.size.height)), count: 7), spacing: SWidth(2, geo.size.height)) {
                                ForEach(weekdayEmjioSymbols().indices, id: \.self) { index in
                                    Image(weekdayEmjioSymbols()[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: SWidth(30, geo.size.height), height: SWidth(30, geo.size.height))
                                }
                            }
                            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: SWidth(2, geo.size.height)), count: 7), spacing: SWidth(2, geo.size.height)) {
                                ForEach(tool.weekdaySymbols().indices, id: \.self) { index in
                                    Text(tool.weekdaySymbols()[index])
                                        .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_999999, .leading)
                                        .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                        .font(Font.S_Pro_10(.bold, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                }
                                ForEach(tool.monthLineForCurrentDate().map{DateItem(date: $0)}, id: \.id) { dateItem in
                                    let date = dateItem.date
                                    if date != Date(timeIntervalSince1970: 0) {
                                        ZStack (alignment: .center) {
                                            Text("\(tool.day(date: date))")
                                                .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_666666, .leading)
                                                .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                                .background(content: {
                                                    if tool.day(date: date) == Int(tool.currentDateFormattedDay()) {
                                                        ZStack () {
                                                            RoundedRectangle(cornerRadius: SWidth(10, geo.size.height))
                                                                .foregroundColor(Color.Color_7FA0FF)
                                                                .frame(width:SWidth(20, geo.size.height), height:SWidth(20, geo.size.height))
                                                            RoundedRectangle(cornerRadius: SWidth(9, geo.size.height))
                                                                .foregroundColor(Color.Color_FFFFFF)
                                                                .frame(width:SWidth(18, geo.size.height), height:SWidth(18, geo.size.height))
                                                        }
                                                    } else {
                                                        RoundedRectangle(cornerRadius: 0)
                                                            .foregroundColor(.clear)
                                                            .frame(width:SWidth(10, geo.size.height), height:SWidth(10, geo.size.height))
                                                    }
                                                })
                                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        }
                                    } else {
                                        Text("") // 空文本，不显示内容
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                    }
                    .padding(SWidth(10, geo.size.height))
                }
                .background(Color.Color_FFFFFF)
                .cornerRadius(10)
                .padding(SWidth(10, geo.size.height))
            })
        )
    }
  
}
