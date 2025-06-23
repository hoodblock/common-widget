//
//  EditorMatter.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI


// 写一个描述次

struct EditorMatter: View {
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    
    @FocusState var isFocusedItem: Bool
        
    var isType: MatterType = .item_0
    
    enum MatterType: Int {
        case item_all = 0
        case item_0 = 1
        case item_1 = 2
        case item_2 = 3
        case item_3 = 4
    }
    
    var body: some View {
        HStack () {
            Text(isType == .item_0 ? "Name" : isType == .item_1 ? "Matter" : isType == .item_2 ? "Date" : "Date")
                .foregroundColor(Color.Color_393672)
                .font(.S_Pro_14())
            TextField("", text: isType == .item_0 ? $config.itemConfig_0.text : isType == .item_1 ? $config.itemConfig_1.text : isType == .item_2 ? $config.itemConfig_2.text : $config.itemConfig_3.text, prompt: Text("Change Title").font(.S_Pro_12()))
                .frame(height: 40)
                .padding(.horizontal, 12)
                .background(Color.Color_F6F6F6)
                .cornerRadius(10)
                .focused($isFocusedItem)
            Image("matter_clear")
                .onTapGesture {
                    isFocusedItem = true
                    switch isType {
                    case .item_all:
                        config.itemConfig_0.text = ""
                        config.itemConfig_1.text = ""
                        config.itemConfig_2.text = ""
                        config.itemConfig_3.text = ""
                    case .item_0:
                        config.itemConfig_0.text = ""
                    case .item_1:
                        config.itemConfig_1.text = ""
                    case .item_2:
                        config.itemConfig_2.text = ""
                    case .item_3:
                        config.itemConfig_3.text = ""
                    }
                    config.backgroundColor = config.backgroundColor
                }
        }
        .padding(.leading, 0)
    }
}

struct EditorMatter_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
