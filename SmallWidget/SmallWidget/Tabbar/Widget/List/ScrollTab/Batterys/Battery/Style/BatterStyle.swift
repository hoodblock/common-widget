//
//  BatterStyle.swift
//  SmallWidget
//
//  Created by Q801 on 2024/4/17.
//

import Foundation
import SwiftUI
import WidgetKit


/**
 ============================================================【 Style 】============================================================
 */

// MARK: - Style

struct BatteryStyleImageView {
    
    static func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    static func imageView(configure: JRWidgetConfigure?, type: Int) -> some View {
        var imageString = "battery_style_01_icon"
        var batterNumber: Int = 20
        if configure!.isInLayout == 0 {
            if BatteryNumber.battery() <= 20 {
                imageString = "battery_style_01_icon"
            } else if BatteryNumber.battery() < 40 {
                imageString = "battery_style_04_icon"
            } else if BatteryNumber.battery() < 60 {
                imageString = "battery_style_06_icon"
            } else {
                imageString = "battery_style_09_icon"
            }
            batterNumber = BatteryNumber.battery()
        } else {
            if type == 0 {
                imageString = "battery_style_01_icon"
                batterNumber = 20
            } else if type == 1 {
                imageString = "battery_style_04_icon"
                batterNumber = 40
            } else if type == 2 {
                imageString = "battery_style_06_icon"
                batterNumber = 60
            } else {
                imageString = "battery_style_09_icon"
                batterNumber = 80
            }
        }
        return GeometryReader { geo in
            VStack (alignment: .center, spacing: SWidth(10, geo.size.height)) {
                Spacer()
                Image(imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack (alignment: .bottom, spacing: 0) {
                    Spacer()
                    Text(String(batterNumber))
                        .font(Font.S_Pro_20(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    Text("%")
                        .font(Font.S_Pro_12(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                    Spacer()
                }
                Spacer()
            }
            .padding([.leading, .trailing], SWidth(20, geo.size.height))
            .gradientForeColor(configure?.itemConfig_0.textColor ?? Color.String_Color_000000, .leading)
        }
    }
}



// MARK: - Style

struct BatteryStyleSmall_0: JRWidgetView {
    
    // 精确到0.01 不精确
    let battery: Float = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLvl = UIDevice.current.batteryLevel
        return batteryLvl
    }()
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.battery, .small)
       
        self.configure?.nameConfig?.viewName = "BatteryStyleSmall_0"
        self.configure?.nameConfig?.orialName = "Style Battery"
        self.configure?.nameConfig?.typeName = "Style Battery"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                BatteryStyleImageView.imageView(configure: configure, type: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


struct BatteryStyleSmall_1: JRWidgetView {
    
    // 精确到0.01 不精确
    let battery: Float = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLvl = UIDevice.current.batteryLevel
        return batteryLvl
    }()
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.battery, .small)
       
        self.configure?.nameConfig?.viewName = "BatteryStyleSmall_1"
        self.configure?.nameConfig?.orialName = "Style Battery"
        self.configure?.nameConfig?.typeName = "Style Battery"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                BatteryStyleImageView.imageView(configure: configure, type: 1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


struct BatteryStyleSmall_2: JRWidgetView {
    
    // 精确到0.01 不精确
    let battery: Float = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLvl = UIDevice.current.batteryLevel
        return batteryLvl
    }()
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.battery, .small)
       
        self.configure?.nameConfig?.viewName = "BatteryStyleSmall_2"
        self.configure?.nameConfig?.orialName = "Style Battery"
        self.configure?.nameConfig?.typeName = "Style Battery"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                BatteryStyleImageView.imageView(configure: configure, type: 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



struct BatteryStyleSmall_3: JRWidgetView {
    
    // 精确到0.01 不精确
    let battery: Float = {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLvl = UIDevice.current.batteryLevel
        return batteryLvl
    }()
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.battery, .small)
       
        self.configure?.nameConfig?.viewName = "BatteryStyleSmall_3"
        self.configure?.nameConfig?.orialName = "Style Battery"
        self.configure?.nameConfig?.typeName = "Style Battery"
        self.configure?.backgroundColor = Color.String_Color_FFFFFF
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 1
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                BatteryStyleImageView.imageView(configure: configure, type: 3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
