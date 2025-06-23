//
//  SeaOfFlowersPlan.swift
//  SmallWidget
//
//  Created by Thomas on 2024/10/25.
//

import SwiftUI
import WidgetKit

/**
 ============================================================【 Sea Of Flowers 】============================================================
 */

// MARK: - Kaka

struct TodoSeaOfFlowersSmall: JRWidgetView {
    
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        
        self.configure = WidgetViewConfig.widgetViewConfig(.todo, .small)
                
        // name
        self.configure?.nameConfig?.viewName = "TodoSeaOfFlowersSmall"
        self.configure?.nameConfig?.orialName = "Sea Of Flowers Plan"
        self.configure?.nameConfig?.typeName = "Sea Of Flowers Plan"
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 0
        self.configure?.itemConfig_0.textListCount = 4
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader { geo in
            if configure?.backgroundImageData?.count ?? 0 > 0 {
                AnyView(lazyItemView(geo: geo))
            } else {
                Image("todo_small_12")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        AnyView(lazyItemView(geo: geo))
                    }
            }
        }
    }
    
    func lazyItemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack (alignment: .center, spacing: SWidth(5, geo.size.height)) {
                VStack(alignment: .leading, spacing: SWidth(3, geo.size.height)) {
                    ForEach(0..<(self.configure?.itemConfig_0.textList.count ?? 0), id: \.self) { index in
                        if (self.configure?.itemConfig_0.textListCount)! > index {
                            if ((self.configure?.itemConfig_0.textList[index])!.count > 0) {
                                HStack (alignment: .center, spacing: SWidth(2, geo.size.height)) {
                                    Image((self.configure?.itemConfig_0.textList[index])!.count > 0 ? ((self.configure?.itemConfig_0.textListSelected[index])! ? "todo_small_12_delected" : "todo_small_12_default") : "")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                    Text(" " + (self.configure?.itemConfig_0.textList[index])! )
                                        .font(Font.S_Pro_12(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                        .lineLimit(1)
                                }
                            }
                        }
                    }
                }
            }
            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_285279, .leading)
            .padding(SWidth(20, geo.size.height))
        )
    }
}



//
struct TodoSeaOfFlowersMedium: JRWidgetView {
   
    var configure: JRWidgetConfigure?
    
    init(_ configure: JRWidgetConfigure? = nil) {
        
        self.configure = configure
        if ((configure != nil) && (self.configure?.nameConfig?.viewName?.count ?? 0 > 0)) {
            return
        }
        self.configure = WidgetViewConfig.widgetViewConfig(.todo, .medium)
                
        // name
        self.configure?.nameConfig?.viewName = "TodoSeaOfFlowersMedium"
        self.configure?.nameConfig?.orialName = "Sea Of Flowers Plan"
        self.configure?.nameConfig?.typeName = "Sea Of Flowers Plan"
        self.configure?.isNeedTextColorEdit = 1
        self.configure?.isNeedBackgroudColorEdit = 0
        self.configure?.itemConfig_0.textListCount = 4
    }
    
    func SWidth(_ width: CGFloat, _ geoHeight: CGFloat = 0.00) -> CGFloat {
        geoHeight * width / 155.0
    }
    
    var body: some View {
        GeometryReader { geo in
            if configure?.backgroundImageData?.count ?? 0 > 0 {
                AnyView(lazyItemView(geo: geo))
            } else {
                Image("todo_medium_12")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay {
                        AnyView(lazyItemView(geo: geo))
                    }
            }
        }
    }
        
    func lazyItemView(geo: GeometryProxy) -> any View {
        AnyView(
            VStack (alignment: .center, spacing: 0) {
                HStack (alignment: .center, spacing: 0) {
                    VStack(alignment: .leading, spacing: SWidth(3, geo.size.height)) {
                        ForEach(0..<(self.configure?.itemConfig_0.textList.count ?? 0), id: \.self) { index in
                            if (self.configure?.itemConfig_0.textListCount)! > index {
                                if ((self.configure?.itemConfig_0.textList[index])!.count > 0) {
                                    HStack (alignment: .center, spacing: SWidth(2, geo.size.height)) {
                                        Image((self.configure?.itemConfig_0.textList[index])!.count > 0 ? ((self.configure?.itemConfig_0.textListSelected[index])! ? "todo_small_12_delected" : "todo_small_12_default") : "")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: SWidth(15, geo.size.height), height: SWidth(15, geo.size.height))
                                        Text(" " + (self.configure?.itemConfig_0.textList[index])! )
                                            .lineLimit(1)
                                            .font(Font.S_Pro_12(.regular, geo.size.height, (configure?.itemConfig_0.textFont)!))
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .gradientForeColor(self.configure?.itemConfig_0.textColor ?? Color.String_Color_285279, .leading)
            .padding([.leading, .trailing], SWidth(40, geo.size.height))
        )
    }
    
}
