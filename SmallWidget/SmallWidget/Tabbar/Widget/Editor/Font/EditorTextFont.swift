//
//  EditorTextFont.swift
//  SmallWidget
//
//  Created by Q801 on 2024/3/8.
//

import SwiftUI

struct EditorTextFont: View {
        
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    
    var textFontTag: MatterType = .item_all // 0 ； 全部改变 1 : 只改变title / 2: 只改变detail / 3: 只改变 date
    
    enum MatterType {
        case item_all
        case item_0
        case item_1
        case item_2
        case item_3
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: ViewLayout.S_W_5()){
            Text("Text Font")
                .foregroundColor(Color.Color_393672)
                .font(.S_Pro_14())
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:5) {
                    ForEach(WidgetStyle.textFonts.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: ViewLayout.S_W_10())
                            .fill((textFontTag == .item_all || textFontTag == .item_0) ? (config.itemConfig_0.textFont == WidgetStyle.textFonts[index] ? Color.Color_000000 : .clear) : ((textFontTag == .item_1) ? (config.itemConfig_1.textFont == WidgetStyle.textFonts[index] ? Color.Color_000000 : .clear) : (config.itemConfig_2.textFont == WidgetStyle.textFonts[index] ? Color.Color_000000 : .clear)))
                            .frame(width: ViewLayout.S_W_60(), height: ViewLayout.S_W_20())
                            .overlay {
                                Text("ColorFul")
                                    .font((Font.S_Pro_9(.regular, UIScreen.main.bounds.size.width / 2, index)))
                                    .foregroundColor((textFontTag == .item_all || textFontTag == .item_0) ? (config.itemConfig_0.textFont == WidgetStyle.textFonts[index] ? Color.Color_FFFFFF : Color.Color_000000) : ((textFontTag == .item_1) ? (config.itemConfig_1.textFont == WidgetStyle.textFonts[index] ? Color.Color_FFFFFF : Color.Color_000000) : (config.itemConfig_2.textFont == WidgetStyle.textFonts[index] ? Color.Color_FFFFFF : Color.Color_000000)))
                                    .frame(width: ViewLayout.S_W_50(), height: ViewLayout.S_W_20())
                                    .minimumScaleFactor(0.6)
                            }
                            
                            .onTapGesture {
                                if textFontTag == .item_all {
                                    config.itemConfig_0.textFont = WidgetStyle.textFonts[index]
                                    config.itemConfig_1.textFont  = WidgetStyle.textFonts[index]
                                    config.itemConfig_2.textFont  = WidgetStyle.textFonts[index]
                                } else if textFontTag == .item_0 {
                                    config.itemConfig_0.textFont = WidgetStyle.textFonts[index]
                                } else if textFontTag == .item_1 {
                                    config.itemConfig_1.textFont  = WidgetStyle.textFonts[index]
                                } else if textFontTag == .item_2 {
                                    config.itemConfig_2.textFont  = WidgetStyle.textFonts[index]
                                } else if textFontTag == .item_3 {
                                    config.itemConfig_3.textFont  = WidgetStyle.textFonts[index]
                                }
                                config.backgroundColor = config.backgroundColor
                            }
                    }
                }
            }
        }
    }
}
