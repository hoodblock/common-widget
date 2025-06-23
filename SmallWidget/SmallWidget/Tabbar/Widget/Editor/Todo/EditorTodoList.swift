//
//  EditorTodoList.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI

struct EditorTodoList: View {
      

    func actionFocusedItem(_ index: Int) {
        if index == 0 {
            isFocusedList_0 = true
        } else if index == 1 {
            isFocusedList_1 = true
        } else if index == 2 {
            isFocusedList_2 = true
        } else if index == 3 {
            isFocusedList_3 = true
        } else if index == 4 {
            isFocusedList_4 = true
        } else if index == 5 {
            isFocusedList_5 = true
        }
    }
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改
    
    @FocusState var isFocusedList_0: Bool
    @FocusState var isFocusedList_1: Bool
    @FocusState var isFocusedList_2: Bool
    @FocusState var isFocusedList_3: Bool
    @FocusState var isFocusedList_4: Bool
    @FocusState var isFocusedList_5: Bool
        
    var body: some View {
        VStack (alignment: .leading, spacing: ViewLayout.S_W_5()) {
            Text("To List")
                .foregroundColor(Color.Color_393672)
                .font(.S_Pro_14())
            Spacer()
            ForEach(0..<config.itemConfig_0.textListCount) { index in
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.Color_979797, lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                        .padding(ViewLayout.SWidth(5))
                        .overlay {
                            config.itemConfig_0.textListSelected[index] ? Image("todo_seleted") : Image("")
                        }
                        .padding(.leading, 13)
                        .onTapGesture {
                            config.itemConfig_0.textListSelected[index].toggle()
                            actionFocusedItem(index)
                            config.backgroundColor = config.backgroundColor
                        }
                    TextField("", text: $config.itemConfig_0.textList[index], prompt: Text("Click to enter your plan").foregroundColor(Color.Color_979797).font(.S_Pro_13()))
                        .padding(.horizontal,13)
                        .focused( index == 0 ? $isFocusedList_0 : index == 1 ? $isFocusedList_1 : index == 2 ? $isFocusedList_2 : index == 3 ? $isFocusedList_3 : index == 4 ? $isFocusedList_4 : $isFocusedList_5)
                    Image("todo_clear")
                        .padding(.trailing, 10)
                        .visibility(hidden: .constant(config.itemConfig_0.textList[index] == ""))
                        .onTapGesture {
                            config.itemConfig_0.textList[index] = ""
                            config.itemConfig_0.textListSelected[index] = false
                            actionFocusedItem(index)
                            config.backgroundColor = config.backgroundColor
                        }
                }
                .tag(index)
                .frame(height: ViewLayout.S_H_20() * 2)
                .background(Color.Color_F4F4F5)
                .cornerRadius(ViewLayout.S_H_20())
            }
        }
    }
    
}

struct EditorTodoList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
