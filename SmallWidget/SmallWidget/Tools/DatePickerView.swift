//
//  DatePickerView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/14.
//

import SwiftUI

struct DatePickerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    typealias Label = String
    typealias Entry = String
    
    @State var dateString: [(Label, [Entry])] = [
        ("Year", Array(2000...CalendarTool.currentYear()).map{"\($0)"}),
        ("Month", ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]),
        ("Day", Array(1...31).map{ day in
            DatePickerView.dayNumberToString(day)
        })
    ]
    
    @Binding var currentSelectedDate: [Entry]

    @State var currentSelectedYearString: Entry = ""
    @State var currentSelectedMonthString: Entry = ""
    @State var currentSelectedDayString: Entry = ""
   
    @State var currentSelectedYear: Entry = ""
    @State var currentSelectedMonth: Entry = ""
    @State var currentSelectedDay: Entry = ""
    
    var body: some View {
        Color.white.opacity(0.4).edgesIgnoringSafeArea(.all)
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
                        
                    HStack (spacing: 0){
                        
                        Picker(dateString[0].0, selection: $currentSelectedYearString) {
                            ForEach(0..<dateString[0].1.count, id:\.self) { row in
                                Text(verbatim: dateString[0].1[row])
                                    .tag(dateString[0].1[row])
                                    .foregroundColor(Color.pickerText)
                                    .font(.S_Pro_23())
                            }
                        }
                        .pickerStyle(.wheel)
                    
                        Picker(dateString[1].0, selection: $currentSelectedMonthString) {
                            ForEach(0..<dateString[1].1.count, id:\.self) { row in
                                if currentSelectedYearString == String(CalendarTool.currentYear()) {
                                    if (DatePickerView.monthStringToNumber(dateString[1].1[row]) <= CalendarTool.currentMonth()) {
                                        Text(verbatim: dateString[1].1[row])
                                            .tag(dateString[1].1[row])
                                            .foregroundColor(Color.pickerText)
                                            .font(.S_Pro_23())
                                    }
                                } else {
                                    Text(verbatim: dateString[1].1[row])
                                        .tag(dateString[1].1[row])
                                        .foregroundColor(Color.pickerText)
                                        .font(.S_Pro_23())
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                    
                        Picker(dateString[2].0, selection: $currentSelectedDayString) {
                            ForEach(0..<dateString[2].1.count, id:\.self) { row in
                                if (currentSelectedYearString == String(CalendarTool.currentYear())) && (currentSelectedMonthString == DatePickerView.monthNumberToString(CalendarTool.currentMonth()))  {
                                    if (DatePickerView.dayStringToNumber(dateString[2].1[row]) <= CalendarTool.currentDay()) {
                                        Text(verbatim: dateString[2].1[row])
                                            .tag(dateString[2].1[row])
                                            .foregroundColor(Color.pickerText)
                                            .font(.S_Pro_23())
                                    }
                                } else {
                                    Text(verbatim: dateString[2].1[row])
                                        .tag(dateString[2].1[row])
                                        .foregroundColor(Color.pickerText)
                                        .font(.S_Pro_23())
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    .background(Color.white)
                    .onChange(of: currentSelectedMonthString) { value in
                        switch value {
                        case "January","March","May","July","August","October","December":
                            dateString[2] = ("Day", Array(1...31).map{ day in
                                DatePickerView.dayNumberToString(day)
                            })
                        case "April","June","September","November":
                            dateString[2] = ("Day", Array(1...30).map{ day in
                                DatePickerView.dayNumberToString(day)
                            })
                        case "February":
                            let isLeap = isLeapYear(Int(currentSelectedYearString) ?? 0)
                            if isLeap == true {
                                dateString[2] = ("Day", Array(1...29).map{ day in
                                    DatePickerView.dayNumberToString(day)
                                })
                            }else {
                                dateString[2] = ("Day", Array(1...28).map{ day in
                                    DatePickerView.dayNumberToString(day)
                                })
                            }
                        default: break
                        }
                    }
                    .onChange(of: currentSelectedYearString) { value in
                        if currentSelectedMonthString == "February" {
                            if isLeapYear(Int(currentSelectedYearString) ?? 0) {
                                dateString[2] =   ("Day", Array(1...29).map{ day in
                                    DatePickerView.dayNumberToString(day)
                                })
                            }else {
                                dateString[2] =   ("Day", Array(1...28).map{ day in
                                    DatePickerView.dayNumberToString(day)
                                })
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.Color_8682FF)
                        .frame(height:50)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .overlay {
                            Text("Confirm Time")
                                .foregroundColor(Color.white)
                        }
                        .onTapGesture {
                            let mo: Int = dateString[1].1.firstIndex(of: currentSelectedMonthString) ?? 0
                            let da: Int = dateString[2].1.firstIndex(of: currentSelectedDayString) ?? 0
                            currentSelectedDate = [currentSelectedYearString, "\(mo+1)" , "\(da+1)"]
                            dismiss()
                        }
                }
            }
            .onTapGesture {
                dismiss()
            }
    }
    
    func isLeapYear(_ year: Int) -> Bool {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)
    }
}

extension DatePickerView {
    
    static func monthNumberToString(_ number: Int) -> String {
         switch number {
         case 1:
             "January"
         case 2:
             "February"
         case 3:
             "March"
         case 4:
             "April"
         case 5:
             "May"
         case 6:
             "June"
         case 7:
             "July"
         case 8:
             "August"
         case 9:
             "September"
         case 10:
             "October"
         case 11:
             "November"
         case 12:
             "December"
         default:
             "January"
         }
     }
    
    static func monthStringToNumber(_ monthString: String) -> Int {
         switch monthString {
         case "January":
             1
         case "February":
             2
         case "March":
             3
         case "April":
             4
         case "May":
             5
         case "June":
             6
         case "July":
             7
         case "August":
             8
         case "September":
             9
         case "October":
             10
         case "November":
             11
         case "December":
             12
         default:
             1
         }
     }
    
    
    static func dayNumberToString(_ number: Int) -> String {
         switch number {
         case 1:
             "1st"
         case 2:
             "2nd"
         case 3:
             "3rd"
         default:
             String(number) + "th"
         }
     }
    
    static func dayStringToNumber(_ numberString: String) -> Int {
        return Int(numberString.prefix(numberString.count - 2))!
    }
    
}


