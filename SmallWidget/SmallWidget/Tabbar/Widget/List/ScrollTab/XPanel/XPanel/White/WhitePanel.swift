//
//  WhitePanel.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/1.
//

import SwiftUI
import WidgetKit



/**
 ============================================================【 White 】============================================================
 */

struct XPanelWhiteSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.XPanel, .small)

        // name
        self.configure?.nameConfig?.viewName = "XPanelWhiteSmall"
        self.configure?.nameConfig?.orialName = "White Panel"
        self.configure?.nameConfig?.typeName = "White Panel"
        self.configure?.isNeedTextColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
        
    var body: some View {
        GeometryReader { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                AnyView(whitePanelItemView(geo: geo))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF))
        }
    }

    func whitePanelItemView(geo: GeometryProxy) -> any View {
        AnyView (
            VStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                //
                HStack(alignment: .center, spacing: SWidth(10, geo.size.height)) {
                    // 日期
                    VStack (spacing: 0) {
                        Spacer()
                        VStack (spacing: SWidth(3, geo.size.height)) {
                            Text("\(CalendarTool().currentWeekdayString())")
                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("\(CalendarTool().currentDateFormattedDay())")
                                .font(Font.S_Pro_15(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            Text("\(CalendarTool().currentDateFormattedYear()) - \(CalendarTool().currentDateFormattedMonth())")
                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        }
                        .padding([.top, .bottom], SWidth(2, geo.size.height))
                        .padding([.leading, .trailing], SWidth(2, geo.size.height))
                        Spacer()
                    }
                    .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                    .cornerRadius(SWidth(5, geo.size.height))
                  
                    // 内存
                    VStack (alignment: .center) {
                        Spacer(minLength: 0)
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: SWidth(2, geo.size.height))
                                .overlay {
                                    CircleSection(startAngle: .degrees(UIDevice().getMemoryUsageRatio().0), endAngle: .degrees(UIDevice().getMemoryUsageRatio().1))
                                        .stroke(Color.Color_7AD246, lineWidth: SWidth(3, geo.size.height))
                                        .padding(SWidth(2, geo.size.height))
                                        .overlay {
                                            Circle()
                                                .stroke(Color.white, lineWidth: SWidth(2, geo.size.height))
                                                .padding(SWidth(5, geo.size.height))
                                                .overlay {
                                                   Text("Storage")
                                                        .font(Font.S_Pro_8(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                }
                                        }
                                  
                                    }
                        }
                        .padding(.top, SWidth(5, geo.size.height))
                        .padding([.leading, .trailing], SWidth(10, geo.size.height))

                        VStack() {
                            Text("Used Space")
                            Text(UIDevice.current.usedDiskSpaceInGB)
                        }
                        .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        Spacer(minLength: 0)
                    }
                    .padding([.leading, .trailing], SWidth(2, geo.size.height))
                    .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                    .cornerRadius(SWidth(5, geo.size.height))
                }
                
                // 底部
                HStack {
                    Spacer()
                    VStack (spacing: SWidth(5, geo.size.height)) {
                        Text(DeviceInfoUtil.modelName)
                            .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                        Text(" " + DeviceInfoUtil.getChipModel())
                            .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    }
                    .padding([.top, .bottom], SWidth(5, geo.size.height))
                    Spacer()
                }
                .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                .cornerRadius(SWidth(5, geo.size.height))
            }
            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_454A4D, .leading)
            .padding(SWidth(10, geo.size.height))

        )
    }
}


//
struct XPanelWhiteMedium: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.XPanel, .medium)

        // name
        self.configure?.nameConfig?.viewName = "XPanelWhiteMedium"
        self.configure?.nameConfig?.orialName = "White Panel"
        self.configure?.nameConfig?.typeName = "White Panel"
        self.configure?.isNeedTextColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                AnyView(whitePanelItemView(geo: geo))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF))
        }
    }

    func whitePanelItemView(geo: GeometryProxy) -> any View {
        AnyView (
            HStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                // 左边
                HStack (alignment: .center, spacing: 0) {
                    Spacer(minLength: 0)
                    VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                        // 日期
                        HStack(alignment: .center) {
                            Spacer(minLength: 0)
                            VStack (spacing: SWidth(2, geo.size.height)) {
                                Text("\(CalendarTool().currentWeekdayString())")
                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                Text("\(CalendarTool().currentDateFormattedDay())")
                                    .font(Font.S_Pro_15(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                Text("\(CalendarTool().currentDateFormattedYear()) - \(CalendarTool().currentDateFormattedMonth())")
                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            }
                            .padding(SWidth(5, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                        .cornerRadius(SWidth(5, geo.size.height))
                        .shadow(color: .white, radius: 5 )
                        
                        // 内存
                        HStack(alignment: .center) {
                            Spacer(minLength: 0)
                            VStack (alignment: .center, spacing: 0) {
                                ZStack {
                                    Circle()
                                        .stroke(Color.white, lineWidth: SWidth(2, geo.size.height))
                                        .overlay {
                                            CircleSection(startAngle: .degrees(UIDevice().getMemoryUsageRatio().0), endAngle: .degrees(UIDevice().getMemoryUsageRatio().1))
                                                .stroke(Color.Color_7AD246, lineWidth: SWidth(3, geo.size.height))
                                                .padding(SWidth(2, geo.size.height))
                                                .overlay {
                                                    Circle()
                                                        .stroke(Color.white, lineWidth: SWidth(2, geo.size.height))
                                                        .padding(SWidth(5, geo.size.height))
                                                        .overlay {
                                                           Text("Storage")
                                                                .font(Font.S_Pro_8(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                                        }
                                                }

                                            }
                                }
                                .padding(.top, SWidth(5, geo.size.height))

                                VStack() {
                                    Text("Used Space")
                                    Text(UIDevice.current.usedDiskSpaceInGB)
                                }
                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            }
                            .padding([.leading, .trailing], SWidth(10, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                        .cornerRadius(SWidth(5, geo.size.height))
                        .shadow(color: .white, radius: 5 )
                    }
                    Spacer(minLength: 0)
                }
                .frame(width: geo.size.width / 4)
                // 中间
                VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                    // 时间
                    HStack (alignment: .center) {
                        Spacer(minLength: 0)
                        VStack (alignment: .center) {
                            Spacer(minLength: 0)
                            Text(CalendarTool.showCurrentTimehsString())
                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .padding([.top, .bottom], SWidth(10, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        Spacer(minLength: 0)
                    }
                    .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                    .cornerRadius(SWidth(5, geo.size.height))
                    .shadow(color: .white, radius: 5 )
                    
                    // 芯片
                    HStack (alignment: .center) {
                        Spacer(minLength: 0)
                        VStack (alignment: .center) {
                            Spacer(minLength: 0)
                            Text(" " + DeviceInfoUtil.getChipModel())
                                .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                .padding([.top, .bottom], SWidth(10, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        Spacer(minLength: 0)
                    }
                    .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                    .cornerRadius(SWidth(5, geo.size.height))
                    .shadow(color: .white, radius: 5 )

                    // 手机类型 & Wi-Fi
                    HStack (alignment: .center, spacing: 0) {
                        Spacer(minLength: 0)
                        VStack (alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            HStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                HStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                    Spacer(minLength: 0)
                                    VStack (alignment: .center, spacing: 0) {
                                        Spacer(minLength: 0)
                                        Text(DeviceInfoUtil.modelName)
                                            .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                            .multilineTextAlignment(.center)
                                            .lineLimit(2)
                                        Spacer(minLength: 0)
                                    }
                                    Spacer(minLength: 0)
                                }
                                .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                                .cornerRadius(SWidth(5, geo.size.height))
                                .shadow(color: .white, radius: 5 )

                                // Wi-Fi
                                HStack (alignment: .center, spacing: 0) {
                                    Spacer(minLength: 0)
                                    VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                        Image(DeviceInfoUtil.wiFiStatus() ? "xpanel_wifi_small_0" : "xpanel_wifi_small_1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        Text(DeviceInfoUtil.wiFiStatus() ? "Wi-Fi" : "Wi-Fi")
                                            .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                    }
                                    .padding(SWidth(5, geo.size.height))
                                    Spacer(minLength: 0)
                                }
                                .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                                .cornerRadius(SWidth(5, geo.size.height))
                                .shadow(color: .white, radius: 5 )
                            }
                            Spacer(minLength: 0)
                        }
                        Spacer(minLength: 0)
                    }
                }

                // 右边
                HStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                    // 蓝牙 & 模型
                    // 蓝牙
                    VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                        HStack (alignment: .center) {
                            Spacer(minLength: 0)
                            VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                                Image(DeviceInfoUtil.getBluetoothState() ? "xpanel_blueboud_small_2" : "xpanel_blueboud_small_3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text(DeviceInfoUtil.getBluetoothState() ? "Bluetooth" : "Bluetooth")
                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            }
                            .padding(SWidth(5, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                        .cornerRadius(SWidth(5, geo.size.height))
                        .shadow(color: .white, radius: 5 )
                        
                        HStack (alignment: .center) {
                            Spacer(minLength: 0)
                            VStack (alignment: .center, spacing: SWidth(2, geo.size.height)) {
                                Image(systemName: "iphone")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                Text("iOS")
                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                Text(DeviceInfoUtil.getDevicesystemVersion())
                                    .font(Font.S_Pro_10(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                            }
                            .padding(SWidth(5, geo.size.height))
                            Spacer(minLength: 0)
                        }
                        .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                        .cornerRadius(SWidth(5, geo.size.height))
                        .shadow(color: .white, radius: 5 )
                    }
                    
                    // 声音
                    VStack (alignment: .center) {
                        VStack (alignment: .center) {
                            GeometryReader { geometry in
                                ZStack (alignment: .bottom) {
                                    Rectangle()
                                        .fill(Color.Color_DFDEDE.opacity(0.74))
                                        .frame(width: geometry.size.width, height: geometry.size.height * 1)
                                        .cornerRadius(SWidth(20, geo.size.height))
                                    Rectangle()
                                        .fill(Color.Color_96DA6C)
                                        .frame(width: geometry.size.width, height: geometry.size.height * (DeviceInfoUtil.getSystemVolumValue()))
                                        .cornerRadius(SWidth(20, geo.size.height))
                                    Image(systemName:  (DeviceInfoUtil.getSystemVolumValue()) == 0 ? "speaker.slash" : "speaker.wave.1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(.white)
                                        .padding([.leading, .trailing], SWidth(2, geo.size.height))
                                        .padding(.bottom, SWidth(5, geo.size.height))
                                }
                                .frame(height: geometry.size.height, alignment: .bottom)
                            }
                        }
                        .padding([.leading, .trailing], SWidth(1))
                        .background(Color.white)
                        .cornerRadius(SWidth(20, geo.size.height))
                    }
                    .frame(width: SWidth(20, geo.size.height))
                    .padding(SWidth(3, geo.size.height))
                    .background(Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_DFDEDE))
                    .cornerRadius(SWidth(20, geo.size.height))
                    .shadow(color: .white, radius: 5 )
                }
            }
            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_454A4D, .leading)
            .padding(SWidth(10, geo.size.height))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

        )
    }
}

