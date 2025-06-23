//
//  MoodColorfulMantou.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/27.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 ColorfulMantou 】============================================================
 */

// MARK: - ColorfulMantou

struct MoodColorfulMantouSmall_0: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.mood, .small)
        
        // name
        self.configure?.nameConfig?.viewName = "MoodColorfulMantouSmall_0"
        self.configure?.nameConfig?.orialName = "ColorfulMantou Style"
        self.configure?.nameConfig?.typeName = "ColorfulMantou Style"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                Image("mood_color_0_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct MoodColorfulMantouSmall_1: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.mood, .small)
        
        // name
        self.configure?.nameConfig?.viewName = "MoodColorfulMantouSmall_1"
        self.configure?.nameConfig?.orialName = "ColorfulMantou Style"
        self.configure?.nameConfig?.typeName = "ColorfulMantou Style"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                Image("mood_color_1_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



struct MoodColorfulMantouSmall_2: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.mood, .small)
        
    
        // name
        self.configure?.nameConfig?.viewName = "MoodColorfulMantouSmall_2"
        self.configure?.nameConfig?.orialName = "ColorfulMantou Style"
        self.configure?.nameConfig?.typeName = "ColorfulMantou Style"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                Image("mood_color_1_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}



struct MoodColorfulMantouSmall_3: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.mood, .small)
        
        // name
        self.configure?.nameConfig?.viewName = "MoodColorfulMantouSmall_3"
        self.configure?.nameConfig?.orialName = "ColorfulMantou Style"
        self.configure?.nameConfig?.typeName = "ColorfulMantou Style"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                Image("mood_color_3_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


struct MoodColorfulMantouSmall_4: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.mood, .small)
        
        // name
        self.configure?.nameConfig?.viewName = "MoodColorfulMantouSmall_4"
        self.configure?.nameConfig?.orialName = "ColorfulMantou Style"
        self.configure?.nameConfig?.typeName = "ColorfulMantou Style"
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader(content: { geo in
            Color.color(hexString: configure?.backgroundColor ?? Color.String_Color_FFFFFF).overlay(alignment: .center) {
                Image("mood_color_4_icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(SWidth(10, geo.size.height))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

