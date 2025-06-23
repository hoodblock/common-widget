//
//  EditorAnniversary.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/11.
//

import SwiftUI

// 日期周期等


struct EditorAnniversary: View {
    
    @ObservedObject var config: JRWidgetConfigure  // 观察属性，及时修改

    @State private var showingData = false
    
    @State private var showingCycle = false
    
    @State var pickDate = [String(CalendarTool.currentYear()), String(CalendarTool.currentMonth()), String(CalendarTool.currentDay())]

    @State private var pickCycle = "No Loop"
    
    var isType: MatterType = .item_0
    
    enum MatterType: Int {
        case item_all = 0
        case item_0 = 1
        case item_1 = 2
        case item_2 = 3
        case item_3 = 4
    }
    
    init(config: JRWidgetConfigure, pickDate: [Swift.String] = [String(CalendarTool.currentYear()), String(CalendarTool.currentMonth()), String(CalendarTool.currentDay())], isType: MatterType) {
        self.config = config
        self.pickDate = pickDate
        self.isType = isType
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Starting Date")
                    .foregroundColor(Color.Color_393672)
                    .font(.S_Pro_14())
                Spacer(minLength: 0)
                Label("\(pickDate[0])-\(pickDate[1])-\(pickDate[2])", image: "wall_arrow")
                    .labelStyle(WLabelBStyle())
                    .fullScreenCover(isPresented: $showingData) {
                        DatePickerView(currentSelectedDate: $pickDate, currentSelectedYearString: pickDate[0], currentSelectedMonthString: DatePickerView.monthNumberToString(Int(pickDate[1])!), currentSelectedDayString: DatePickerView.dayNumberToString(Int(pickDate[2])!), currentSelectedYear: pickDate[0], currentSelectedMonth: pickDate[1], currentSelectedDay: pickDate[2])
                            .background(BackgroundClearView())
                            .onChange(of: pickDate ) { newValue in
                                switch isType {
                                case .item_all:
                                    config.itemConfig_0.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_1.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_2.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_3.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_0:
                                    config.itemConfig_0.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_1:
                                    config.itemConfig_1.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_2:
                                    config.itemConfig_2.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_3:
                                    config.itemConfig_3.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                }
                                config.backgroundColor = config.backgroundColor
                            }
                            .onDisappear {
                                switch isType {
                                case .item_all:
                                    config.itemConfig_0.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_1.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_2.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                    config.itemConfig_3.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_0:
                                    config.itemConfig_0.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_1:
                                    config.itemConfig_1.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_2:
                                    config.itemConfig_2.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                case .item_3:
                                    config.itemConfig_3.textDate = "\(pickDate[0])-\(pickDate[1])-\(pickDate[2])"
                                }
                                config.backgroundColor = config.backgroundColor
                            }
                    }
                    .onTapGesture {
                        showingData.toggle()
                    }
            }
            .padding(.bottom, 6)
            Divider()
                .overlay(Color.dividerBkg)
            HStack {
                Text("Cycle Period")
                    .foregroundColor(Color.Color_393672)
                    .font(.S_Pro_14())
                Spacer(minLength: 0)
                Label(pickCycle, image: "wall_arrow")
                    .labelStyle(WLabelBStyle())
                    .fullScreenCover(isPresented: $showingCycle) {
                        CyclePickerView(config: config, isType: self.isType.rawValue, selected: $pickCycle)
                            .background(BackgroundClearView())
                    }.onTapGesture {
                        showingCycle.toggle()
                    }
            }
            .padding(.top, 20)
            .padding(.bottom, 6)
            Divider()
                .overlay(Color.dividerBkg)
               
        }
    }
    
    
    func loopTypestring() -> String {
        var loopString: String = String()
        switch isType {
        case .item_all:
            loopString = "No Loop"
        case .item_0:
            if config.itemConfig_0.textLoop == 0 {
                loopString = "No Loop"
            } else if config.itemConfig_0.textLoop == 1 {
                loopString = "Monthly"
            } else if config.itemConfig_0.textLoop == 2 {
                loopString = "Quarterly"
            } else if config.itemConfig_0.textLoop == 3 {
                loopString = "Year"
            } else if config.itemConfig_0.textLoop == 4 {
                loopString = "No Loop"
            }
        case .item_1:
            if config.itemConfig_1.textLoop == 0 {
                loopString = "No Loop"
            } else if config.itemConfig_1.textLoop == 1 {
                loopString = "Monthly"
            } else if config.itemConfig_1.textLoop == 2 {
                loopString = "Quarterly"
            } else if config.itemConfig_1.textLoop == 3 {
                loopString = "Year"
            } else if config.itemConfig_1.textLoop == 4 {
                loopString = "No Loop"
            }
        case .item_2:
            if config.itemConfig_2.textLoop == 0 {
                loopString = "No Loop"
            } else if config.itemConfig_2.textLoop == 1 {
                loopString = "Monthly"
            } else if config.itemConfig_2.textLoop == 2 {
                loopString = "Quarterly"
            } else if config.itemConfig_2.textLoop == 3 {
                loopString = "Year"
            } else if config.itemConfig_2.textLoop == 4 {
                loopString = "No Loop"
            }
        case .item_3:
            if config.itemConfig_3.textLoop == 0 {
                loopString = "No Loop"
            } else if config.itemConfig_3.textLoop == 1 {
                loopString = "Monthly"
            } else if config.itemConfig_3.textLoop == 2 {
                loopString = "Quarterly"
            } else if config.itemConfig_3.textLoop == 3 {
                loopString = "Year"
            } else if config.itemConfig_3.textLoop == 4 {
                loopString = "No Loop"
            }
        }
        pickCycle = loopString
        return loopString
    }
}
