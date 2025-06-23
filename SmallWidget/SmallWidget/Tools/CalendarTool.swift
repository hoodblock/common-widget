//
//  CalendarTool.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/26.
//

import Foundation

struct CalendarTool {
    
    let currentDate = Date()
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func currentWeekdayString() -> String {
        let weekday = calendar.component(.weekday, from: currentDate)
        return calendar.standaloneWeekdaySymbols[weekday-1]
    }
    func currentDateFormattedYear() -> String {
        let year = calendar.component(.year, from: currentDate)
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: year)) ?? ""
    }
    
    func currentDateFormattedMonth() -> String {
        let month = calendar.component(.month, from: currentDate)
        return String(format: "%02d", month)
    }
    
    func currentMonthString() -> String {
        let monthNumber = Int(currentDateFormattedMonth()) ?? 1
        switch monthNumber {
         case 1:
             return "January"
         case 2:
             return "February"
         case 3:
            return "March"
         case 4:
            return "April"
         case 5:
            return "May"
         case 6:
            return "June"
         case 7:
            return "July"
         case 8:
            return "August"
         case 9:
            return "September"
         case 10:
            return "October"
         case 11:
            return "November"
         case 12:
            return "December"
         default:
            return "January"
         }
     }
    
    func currentDateFormattedDay() -> String {
        let day = calendar.component(.day, from: currentDate)
        return String(format: "%02d", day)
    }
    
    func monthDates() -> [Date] {
        let components = calendar.dateComponents([.year, .month], from: currentDate)
        let startOfMonth = calendar.date(from: components)!
        let weekday = calendar.component(.weekday, from: startOfMonth)
        let paddingCount = (weekday - calendar.firstWeekday + 7) % 7
        let datesRange = calendar.range(of: .day, in: .month, for: startOfMonth)!
        let dates = datesRange.map { calendar.date(byAdding: .day, value: $0 - 1, to: startOfMonth)! }
        let allDate = Array(repeating: Date(timeIntervalSince1970: 0), count: paddingCount) + dates
        return allDate
    }
    
    func monthLineForCurrentDate() -> [Date] {
        let allDate = monthDates()
        var objectDate = [Date]()
        var index: Int = 0
        var isFind: Bool = false
        for dataItem in allDate.map({ DateItem(date: $0) }) {
            let date = dataItem.date
            if day(date: date) == Int(currentDateFormattedDay()) {
                isFind = true
            }
            if isFind && index == 6 {
                objectDate.append(date)
                return objectDate
            } else {
                objectDate.append(date)
                if index == 6 {
                    index = 0
                    objectDate = [Date]()
                } else {
                    index += 1
                }
            }
        }
        return allDate
    }
    
    // 星期的首字母
    func weekdaySymbols() -> [String] {
        dateFormatter.locale = Locale.current
        return dateFormatter.veryShortWeekdaySymbols
    }
    
    // 星期的首三个字母
    func weekdayThreeSymbols() -> [String] {
        dateFormatter.locale = Locale.current
        return dateFormatter.shortWeekdaySymbols
    }
    
    // 当前日期对应星期几的首三个字母
    func weekdayCurrentSymbols() -> String? {
        dateFormatter.locale = Locale.current
        let weekdayIndex = Calendar.current.component(.weekday, from: Date())
        guard let shortWeekdaySymbols = dateFormatter.shortWeekdaySymbols else {
            return nil
        }
        let weekdayAbbreviation = shortWeekdaySymbols[weekdayIndex - 1]
        return String(weekdayAbbreviation.prefix(3))
    }
    
    // 当前日期对应星期几的数字
    func weekdayCurrentSymbols() -> Int? {
        dateFormatter.locale = Locale.current
        let weekdayIndex = Calendar.current.component(.weekday, from: Date())
        return weekdayIndex
    }
    
    // 获取当前日期是今年的第几天
    func dayOfYear() -> Int {
        return calendar.ordinality(of: .day, in: .year, for: currentDate) ?? 0
    }

    // 获取当前日期是今年的第几周
    func weekOfYear() -> Int {
        return calendar.component(.weekOfYear, from: currentDate)
    }
    
    func day(date: Date) ->Int{
       return calendar.component(.day, from: date)
    }
    
    
    // MARK: - 获取当前年
    static func currentYear() -> Int {
        let date = Date()
        let calender = Calendar.current
        let d = calender.dateComponents([Calendar.Component.year, Calendar.Component.month], from: date)
        return d.year!
    }
    
    // MARK: - 获取当前月
    static func currentMonth() -> Int {
        let date = Date()
        let calender = Calendar.current
        let d = calender.dateComponents([Calendar.Component.year, Calendar.Component.month], from: date)
        return d.month!
    }
    
    // MARK: - 获取当前第几天
    static func currentDay() -> Int {
        let date = Date()
        let calender = Calendar.current
        let d = calender.dateComponents([Calendar.Component.year,  Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute], from: date)
        return d.day!
    }
    
    // MARK: - 获取当前时间戳数字
    static func currentTimeInterval() -> Int64 {
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return CLongLong(timeInterval)
    }
    
    // MARK: - 获取当前时间戳字符串
    static func currentTimeIntervalString(_ isHours: Bool = false) -> String {
        let now = Date()
        let dformatter = DateFormatter()
        if isHours {
            dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            dformatter.dateFormat = "yyyy-MM-dd"
        }
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return String(format: "%@", timeInterval)
    }
    
    // MARK: - 时间戳转化为时间
    static func dateFormatString(timeStamp: Int64, _ isShowHoure:Bool = true, _ isShowDay:Bool = true) -> String {
        let interval: TimeInterval = TimeInterval.init(timeStamp)
        let date = Date(timeIntervalSince1970: interval)
        let dateformatter = DateFormatter()
        if isShowDay && isShowHoure {
            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else if !isShowDay && !isShowHoure {
            dateformatter.dateFormat = "yyyy-MM"
        } else {
            dateformatter.dateFormat = "yyyy-MM-dd"
        }
        var dataString = dateformatter.string(from: date)
//        if SuperPreferenceUtil.getAPPLanguage().id == 2 { // 简体
//            if dataString.contains("AM") {
//                dataString = dataString.replacingOccurrences(of: "AM", with: "上午")
//            } else if dataString.contains("FM") {
//                dataString = dataString.replacingOccurrences(of: "FM", with: "下午")
//            }
//        } else if SuperPreferenceUtil.getAPPLanguage().id == 3 {
//
//        }
        return dateformatter.string(from: date)
    }


    //获取当前年月日
    static func currentDateComponents() -> DateComponents {
        return Calendar.current.dateComponents([.year, .month, .day], from: Date())
    }

    // MARK: - 当前时间
    static func showCurrentTimeString(_ isShowHours: Bool = false) -> String {
        let currnetDate = Date().timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: currnetDate)
        let dfmatter = DateFormatter()
        if isShowHours {
            dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            dfmatter.dateFormat = "yyyy-MM-dd"
        }
        return dfmatter.string(from: date as Date)
    }
    
    // MARK: - 当前时间的十分秒
    static func showCurrentTimehsString(_ isSeced: Bool = true) -> String {
        let currnetDate = Date().timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: currnetDate)
        let dfmatter = DateFormatter()
        if isSeced {
            dfmatter.dateFormat = "HH:mm:ss"
        } else {
            dfmatter.dateFormat = "HH:mm"
        }
        return dfmatter.string(from: date as Date)
    }
    
    // MARK: - 当前时间的十分秒
    static func showCurrentTimehsString() -> String {
        let currnetDate = Date().timeIntervalSince1970
        let date = NSDate(timeIntervalSince1970: currnetDate)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "HH:mm:ss"
        return dfmatter.string(from: date as Date)
    }
    
    //获取每个月的天数
    static func manyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        if (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) {
            return 31
        } else if (month == 4) || (month == 6) || (month == 9) || (month == 11) {
            return 30
        } else if (year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3) {
            return 28
        } else if year % 400 == 0 {
            return 29
        } else if year % 100 == 0 {
            return 28
        }
        return 29
    }
    
    //  判断是不是今天
    static func isCurrentDay(timeStamp: Int64) -> Bool {
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return calendar.isDateInToday(date)
    }
    
    //  判断两个时间戳是否在预期差值之内
    let TIMESTAMP_DAY = 60 * 60 * 10
    static func isObjectTimeExpectTargetRangeWithCurrentTime(objectTime: Int64, expectDifference: Int) -> Bool {
        let currentTime = currentTimeInterval()
        if (objectTime - currentTime) > expectDifference {
            return false
        } else if (objectTime < currentTime) {
            return false
        }
        return true
    }
    
    //获取当天开始的日期，给Date增加一个拓展方法
    static func getCurrentDayStart() -> Date {
        let components = DateComponents(year: currentYear(), month: currentMonth(), day: currentDay(), hour: 0, minute: 0, second: 0)
        return Calendar.current.date(from: components)!
    }
    
    static func isSameMonth(timeStamp_1: Int64, timeStamp_2: Int64) -> Bool {
        let interval_1: TimeInterval = TimeInterval.init(timeStamp_1)
        let date_1 = Date(timeIntervalSince1970: interval_1)
        let components_1 = Calendar.current.dateComponents([.year, .month, .day], from: date_1)

        let interval_2: TimeInterval = TimeInterval.init(timeStamp_2)
        let date_2 = Date(timeIntervalSince1970: interval_2)
        let components_2 = Calendar.current.dateComponents([.year, .month, .day], from: date_2)

        if (components_1.year == components_2.year) && (components_1.month == components_2.month) {
            return true
        } else {
            return false
        }
    }
    
    // 获取某个节点的时间戳
    static func timeNode(year: Int, month: Int, day: Int, _ hours: Int = 0) -> Int64 {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        if year > 0 {
            dateComponents.year = year
        }
        if month > 0 {
            dateComponents.month = month
        }
        if day > 0 {
            dateComponents.day = day
        }
        if hours > 0 {
            dateComponents.hour = hours
        }
        let date = calendar.date(from: dateComponents)!
        return  Int64(date.timeIntervalSince1970)
    }
    
    // 获取指定时间距离当前时间的天数
    static func daysSinceTodayInYearAndMonth(_ year: Int, _ month: Int, _ day: Int) -> Int {
        let calendar = Calendar.current
        let today = Date() // 当前时间
        let endDay = calendar.date(from: DateComponents(year: year, month: month, day: day))! // 要计算的时间
        var days: Int = 0
        if today < endDay {
            days = calendar.dateComponents([.day], from: endDay, to: today).day!
            days = -(days - 1)
        } else {
            days = calendar.dateComponents([.day], from: endDay, to: today).day!
        }
        return days
    }
    
    // 当前时间往后推几个月，然后距离今天多少天
    static func daysSinceTodayInMonth(_ month: Int) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
        let futureDate = calendar.date(byAdding: .month, value: month, to: currentDate)!
        let days = calendar.dateComponents([.day], from: currentDate, to: futureDate).day!
        return days
    }
    
    
    static func dateLoop(fromIndex: Int, dateString: String) -> (String, String) {
        if dateString.count == 0 {
            return ("", "")
        }
        let yearInt = Int(dateString.components(separatedBy: "-")[0])!
        let monthInt = Int(dateString.components(separatedBy: "-")[1])!
        var dayInt = Int(dateString.components(separatedBy: "-")[2])!
        if fromIndex == 0 { // 不
            return ((String(yearInt) + "-" + String(monthInt) + "-" + String(dayInt)), String(daysSinceTodayInYearAndMonth(yearInt, monthInt, dayInt)))
        } else if fromIndex == 1 { // 月 (在已经超过指定日期时，自动到下一个月，如果在今年12月份，自动到1月份，然后计算那个时候到现在的时间)
            var objectYear = currentYear()
            var objectMonth = currentMonth()
            var afterDay = 0
            
            if (objectMonth == 12) && (currentDay() - dayInt > 0) {
                objectYear += 1
                objectMonth = 1
            } else if (currentDay() - dayInt > 0) {
                objectMonth += 1
                if dayInt > manyDays(inThisYear: objectYear, withMonth: objectMonth) {
                    dayInt = manyDays(inThisYear: objectYear, withMonth: objectMonth)
                }
            } else {
                if dayInt > manyDays(inThisYear: objectYear, withMonth: objectMonth) {
                    dayInt = manyDays(inThisYear: objectYear, withMonth: objectMonth)
                }
            }
            if (currentDay() - dayInt > 0) {
                afterDay = daysSinceTodayInYearAndMonth(objectYear, objectMonth, dayInt)
            } else {
                afterDay = dayInt - currentDay()
            }
            return ((String(objectYear) + "-" + String(objectMonth) + "-" + String(dayInt)), String(afterDay))
            
        } else if fromIndex == 2 { // 季
            let dateString = dateString
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: dateString)
            let objectYear = nextCycleDate(selectedDate: date!).0
            let objectMonth = nextCycleDate(selectedDate: date!).1
            let objectDay = nextCycleDate(selectedDate: date!).2
            return (objectYear + "-" + objectMonth + "-" + objectDay, String(daysSinceTodayInYearAndMonth(Int(objectYear)!, Int(objectMonth)!, Int(objectDay)!)))
        } else if fromIndex == 3 { // 年 (在已经超过指定日期时，自动到下一个年，然后计算那个时候到现在的时间)
            var objectYear = currentYear()
            var objectMonth = currentMonth()
            var objectDay = currentDay()
            // 比如选择 2022年 9月16日， 那就是每年的9月16, 如果假如现在显示的是2023年11月，那就是距离下一个2024年9月16
            if objectMonth > monthInt {
                objectYear += 1
            } else if (objectMonth == monthInt) {
                if objectDay > dayInt {
                    objectYear += 1
                }
            }
            return ((String(objectYear) + "-" +  String(monthInt) + "-" + String(dayInt)), String(daysSinceTodayInYearAndMonth(objectYear, monthInt, dayInt)))
        }
        return (" - - ", "")
    }
  
    static func nextCycleDate(selectedDate: Date) -> (String, String, String) {
        let calendar = Calendar.current
        // 获取选中的年，获取选中的月
        let selectedMonth = calendar.component(.month, from: selectedDate)
        let selectedDay = calendar.component(.day, from: selectedDate)

        let currentYear = currentYear()
        var currentMonth = currentMonth()
        var currentDay = currentDay()
        var objectYear: Int = currentYear
        var objectMonth: Int = selectedMonth
        var objectDay: Int = selectedDay

        // selected (5月份) current(12月份) object(2月份)
        let selectedQuarter = currentItemMonthFormQuarter(selectedMonth: selectedMonth)
        let currentQuarter = currentItemMonthFormQuarter(selectedMonth: currentMonth)
        
        if (selectedQuarter.itemMonth < currentQuarter.itemMonth) {
            // 下一个季度月份
            objectMonth = currentMonth + (currentQuarter.itemMonth == 1 ? 2 : currentQuarter.itemMonth == 2 ? 1 : currentQuarter.itemMonth == 3 ? 0 : 0) + selectedQuarter.itemMonth
            objectYear = currentYear
            if objectMonth > 12 {
                objectMonth = objectMonth - 12
                objectYear = currentYear + 1
            }
        } else if (selectedQuarter.itemMonth == currentQuarter.itemMonth) {
            if (selectedDay < currentDay) {
                objectMonth = currentMonth + 3
                objectYear = currentYear
                if objectMonth > 12 {
                    objectMonth = objectMonth - 12
                    objectYear = currentYear + 1
                }
            } else if (selectedQuarter.itemQuarter < currentQuarter.itemQuarter) {
                        objectYear = currentYear + 1
            }
        }
        if selectedDay > manyDays(inThisYear: objectYear, withMonth: objectMonth) {
            objectDay = manyDays(inThisYear: objectYear, withMonth: objectMonth)
        }
        return ( String(objectYear), String(objectMonth), String(objectDay))
    }
    
    static func currentItemMonthFormQuarter(selectedMonth: Int) -> (itemQuarter: Int, itemMonth: Int) {
        var itemQuarter: Int = 1
        var itemDay: Int = 1
        if (selectedMonth >= 1 && selectedMonth <= 3) {
            itemQuarter = 1
            if selectedMonth == 1 {
                itemDay = 1
            } else if (selectedMonth == 2) {
                itemDay = 2
            } else if (selectedMonth == 3) {
                itemDay = 3
            }
        } else if (selectedMonth >= 4 && selectedMonth <= 6) {
            itemQuarter = 2
            if selectedMonth == 4 {
                itemDay = 1
            } else if (selectedMonth == 5) {
                itemDay = 2
            } else if (selectedMonth == 6) {
                itemDay = 3
            }
        } else if (selectedMonth >= 7 && selectedMonth <= 9) {
            itemQuarter = 3
            if selectedMonth == 7 {
                itemDay = 1
            } else if (selectedMonth == 8) {
                itemDay = 2
            } else if (selectedMonth == 9) {
                itemDay = 3
            }
        } else if (selectedMonth >= 10 && selectedMonth <= 12) {
            itemQuarter = 4
            if selectedMonth == 10 {
                itemDay = 1
            } else if (selectedMonth == 12) {
                itemDay = 2
            } else if (selectedMonth == 3) {
                itemDay = 3
            }
        }
        let quarter = (itemQuarter, selectedMonth % 3 == 0 ? 3 : selectedMonth % 3)
        return quarter
    }
    
    
    // 今天过去当前时间的百分比
    
//    // 比例要话一个圆，从什么角度到什么角度，默认从中上位置开始（圆认为中左为0，）那么就从270开始
//    func getMemoryUsageRatio() -> (Double , Double) {
//        return (Double(270), Double(270) + Double(usedDiskSpaceInBytes * 360 / totalDiskSpaceInBytes))
//    }
    
    static func scrollCurrentTimeFromStartDayTime() -> (Double, Double, String) {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: now)
        let totalSecondsInDay: Double = 86400 // 一天总共的秒数
        let currentSeconds = Double(components.hour! * 3600 + components.minute! * 60 + components.second!)
        let percentage = (currentSeconds / totalSecondsInDay) * 100
        return (Double(270), Double(270) + Double(currentSeconds * 360 / totalSecondsInDay), String(format: "%.2f%%", percentage))
    }
    
    
    static func scrollCurrentTimeFromStartYearTime() -> (Double, Double, String) {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        let startOfYear = calendar.date(from: DateComponents(year: components.year!))
        let endOfYear = calendar.date(from: DateComponents(year: components.year! + 1))?.addingTimeInterval(-1)
        let totalSecondsInYear = endOfYear!.timeIntervalSince(startOfYear!)
        let currentSeconds = now.timeIntervalSince(startOfYear!)
        let percentage = (currentSeconds / totalSecondsInYear) * 100
        return (Double(270), Double(270) + Double(currentSeconds * 360 / totalSecondsInYear), String(format: "%.2f%%", percentage))
    }
    
    static func weekString() -> (String, String) {
        if CalendarTool().currentWeekdayString() == "Monday" {
            return ("Monday", "Mon")
        } else if CalendarTool().currentWeekdayString() == "Tuesday" {
            return ("Tuesday", "Tues")
        } else if CalendarTool().currentWeekdayString() == "Wednesday" {
            return ("Wednesday", "Wednes")
        } else if CalendarTool().currentWeekdayString() == "Thursday" {
            return ("Thursday", "Thurs")
        } else if CalendarTool().currentWeekdayString() == "Friday" {
            return ("Friday", "Fri")
        } else if CalendarTool().currentWeekdayString() == "Saturday" {
            return ("Saturday", "Satur")
        } else if CalendarTool().currentWeekdayString() == "Sunday" {
            return ("Sunday", "Sun")
        }
        return ("", "")
    }
    
    
}

