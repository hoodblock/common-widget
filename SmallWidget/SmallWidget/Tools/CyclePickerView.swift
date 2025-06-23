//
//  CyclePickerView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/14.
//

import SwiftUI

struct CyclePickerView: View {
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改

    @Environment(\.dismiss) var dismiss
    
    var isType: Int = MatterType.item_all.rawValue
    
    enum MatterType: Int {
        case item_all = 0
        case item_0 = 1
        case item_1 = 2
        case item_2 = 3
        case item_3 = 4
    }
    
    @Binding var selected: String
    
    let data = ["No Loop", "Monthly", "Quarterly", "Year"]

    var body: some View {
        
        Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            .overlay {
                VStack(spacing: 0) {
                    Spacer(minLength: 0)
                    HStack {
                        Spacer(minLength: 0)
                        Image("picker_cancel")
                            .padding(.trailing, 12)
                            .padding(.top, 12)
                            .onTapGesture {
                                dismiss()
                            }
                    }.background(Color.white)
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                    
                    Picker("Cyclle Period", selection: $selected) {
                        ForEach(0..<data.count, id:\.self) { row in
                            Text(data[row])
                                .tag(data[row])
                                .foregroundColor(Color.pickerText)
                                .font(.S_Pro_23())
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(Color.white)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.Color_8682FF)
                        .frame(height:50)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .overlay {
                            Text("Confirm Period")
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            if isType == MatterType.item_all.rawValue {
                                if selected == "No Loop" {
                                    config.itemConfig_0.textLoop = 0
                                } else if selected == "Monthly" {
                                    config.itemConfig_0.textLoop = 0
                                } else if selected == "Quarterly" {
                                    config.itemConfig_0.textLoop = 0
                                } else if selected == "Year" {
                                    config.itemConfig_0.textLoop = 0
                                }
                            } else if isType == MatterType.item_0.rawValue {
                                if selected == "No Loop" {
                                    config.itemConfig_0.textLoop = 0
                                } else if selected == "Monthly" {
                                    config.itemConfig_0.textLoop = 1
                                } else if selected == "Quarterly" {
                                    config.itemConfig_0.textLoop = 2
                                } else if selected == "Year" {
                                    config.itemConfig_0.textLoop = 3
                                }
                            } else if isType == MatterType.item_1.rawValue {
                                if selected == "No Loop" {
                                    config.itemConfig_1.textLoop = 0
                                } else if selected == "Monthly" {
                                    config.itemConfig_1.textLoop = 1
                                } else if selected == "Quarterly" {
                                    config.itemConfig_1.textLoop = 2
                                } else if selected == "Year" {
                                    config.itemConfig_1.textLoop = 3
                                }
                            } else if isType == MatterType.item_2.rawValue {
                                if selected == "No Loop" {
                                    config.itemConfig_2.textLoop = 0
                                } else if selected == "Monthly" {
                                    config.itemConfig_2.textLoop = 1
                                } else if selected == "Quarterly" {
                                    config.itemConfig_2.textLoop = 2
                                } else if selected == "Year" {
                                    config.itemConfig_2.textLoop = 3
                                }
                            } else if isType == MatterType.item_3.rawValue {
                                if selected == "No Loop" {
                                    config.itemConfig_3.textLoop = 0
                                } else if selected == "Monthly" {
                                    config.itemConfig_3.textLoop = 1
                                } else if selected == "Quarterly" {
                                    config.itemConfig_3.textLoop = 2
                                } else if selected == "Year" {
                                    config.itemConfig_3.textLoop = 3
                                }
                            }
                            config.backgroundColor = config.backgroundColor

                            dismiss()
                        }
                }
                
                
                
            }
    }
    
}




struct CyclePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CyclePickerView(config: JRWidgetConfigure(), selected: .constant(""))
    }
}
