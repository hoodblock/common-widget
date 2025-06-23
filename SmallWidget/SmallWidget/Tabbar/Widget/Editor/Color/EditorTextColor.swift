//
//  EditorTextColor.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI

struct EditorTextColor: View {
        
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    @State private var selectedColor: Color = .clear

    var textColorTag: MatterType = .item_all // 0 ； 全部改变 1 : 只改变title / 2: 只改变detail / 3: 只改变 date
    
    enum MatterType {
        case item_all
        case item_0
        case item_1
        case item_2
        case item_3
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: ViewLayout.S_W_5()){
            Text("Text Color")
                .foregroundColor(Color.Color_393672)
                .font(.S_Pro_14())
            Spacer()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing:20) {
                    ColorPicker("", selection: $selectedColor)
                    ForEach(WidgetStyle.textGradientColors.indices, id: \.self) { index in
                        RoundedRectangle(cornerRadius: ViewLayout.S_W_30() / 2)
                            .gradientForeColor(WidgetStyle.textGradientColors[index], .leading)
                            .frame(width: ViewLayout.S_W_30(), height: ViewLayout.S_W_30())
                            .overlay {
                                Image("selected_color")
                                    .fixedSize()
                                    .visibility(hidden: .constant(
                                        (textColorTag == .item_all || textColorTag == .item_0) ? config.itemConfig_0.textColor != WidgetStyle.textGradientColors[index] : textColorTag == .item_1 ? config.itemConfig_1.textColor != WidgetStyle.textGradientColors[index] : config.itemConfig_2.textColor != WidgetStyle.textGradientColors[index]
                                    ))
                            }
                            .onTapGesture {
                                if textColorTag == .item_all {
                                    config.itemConfig_0.textColor = WidgetStyle.textGradientColors[index]
                                    config.itemConfig_1.textColor  = WidgetStyle.textGradientColors[index]
                                    config.itemConfig_2.textColor  = WidgetStyle.textGradientColors[index]
                                } else if textColorTag == .item_0 {
                                    config.itemConfig_0.textColor = WidgetStyle.textGradientColors[index]
                                } else if textColorTag == .item_1 {
                                    config.itemConfig_1.textColor  = WidgetStyle.textGradientColors[index]
                                } else if textColorTag == .item_2 {
                                    config.itemConfig_2.textColor  = WidgetStyle.textGradientColors[index]
                                } else if textColorTag == .item_3 {
                                    config.itemConfig_3.textColor  = WidgetStyle.textGradientColors[index]
                                }
                                config.backgroundColor = config.backgroundColor
                            }
                    }
                }
            }
            .onChange(of: selectedColor) { selectedColor in
                let selectedTextColorString = selectedColor.hexString.replacingOccurrences(of: "#", with: "0xFF")
                if textColorTag == .item_all {
                    config.itemConfig_0.textColor = selectedTextColorString
                    config.itemConfig_1.textColor  = selectedTextColorString
                    config.itemConfig_2.textColor  = selectedTextColorString
                } else if textColorTag == .item_0 {
                    config.itemConfig_0.textColor = selectedTextColorString
                } else if textColorTag == .item_1 {
                    config.itemConfig_1.textColor  = selectedTextColorString
                } else if textColorTag == .item_2 {
                    config.itemConfig_2.textColor  = selectedTextColorString
                } else if textColorTag == .item_3 {
                    config.itemConfig_3.textColor  = selectedTextColorString
                }
                config.backgroundColor = config.backgroundColor
            }
        }
    }
}

struct EditorTextColor_Previews: PreviewProvider {
    static var previews: some View {
        EditorTextColor(config: JRWidgetConfigure())
    }
}
