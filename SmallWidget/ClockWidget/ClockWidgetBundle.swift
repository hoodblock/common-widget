//
//  ClockWidgetBundle.swift
//  ClockWidget
//
//  Created by Thomas on 2023/6/1.
//

import WidgetKit
import SwiftUI


let small_width = "SMALLTYPEPROVIDER_WIDTH"
let small_height = "SMALLTYPEPROVIDER_HEIGHT"
let medium_width = "MEDIUMTYPEPROVIDER_WIDTH"
let medium_height = "MEDIUMTYPEPROVIDER_HEIGHT"
let large_width = "LARGETYPEPROVIDER_WIDTH"
let large_height = "LARGETYPEPROVIDER_HEIGHT"
let group_id = "group.com.subfg"

let dynamic_follow_app = "dynamic_transparentType_follow_app"
let dynamic_top = "dynamic_transparentType_top"
let dynamic_left_top = "dynamic_transparentType_left_top"
let dynamic_right_top = "dynamic_transparentType_right_top"
let dynamic_medium = "dynamic_transparentType_medium"
let dynamic_left_medium = "dynamic_transparentType_left_medium"
let dynamic_right_medium = "dynamic_transparentType_right_medium"
let dynamic_bottom = "dynamic_transparentType_bottom"
let dynamic_left_bottom = "dynamic_transparentType_left_bottom"
let dynamic_right_bottom = "dynamic_transparentType_right_bottom"

let app_name = "Simple Widgets"

//小组件位置枚举
enum SWidgetSizeEnum {
    case topLeft
    case topRight
    case middleLeft
    case middleRight
    case bottomLeft
    case bottomRight
}

//中组件位置枚举
enum MWidgetSizeEnum {
    case top
    case middle
    case bottom
}

//大组件位置枚举
enum LWidgetSizeEnum {
    case top
    case bottom
}


// 小组件的主入口
@main
struct ClockWidgetBundle: WidgetBundle {
    var body: some Widget {
        SmallTypeWidget()
        MediumTypeWidget()
        LargeTypeWidget()
    }
}


extension ClockWidgetBundle {
    
    // 默认文案图
    static func providerView(_ title: String) -> some View {
        Color.clear.ignoresSafeArea(.all).overlay {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 5) {
                    Image("app_background_icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 17, height: 17)
                        .cornerRadius(5)
                    Text(title)
                        .font(Font.S_Pro_11(.medium))
                        .foregroundColor(Color.Color_8682FF)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("1.Add me to the desktop")
                    Text("2.Long click here on the desktop and then click Edit widget to switch the content.")
                }
                .font(Font.S_Pro_10(.medium))
                .foregroundColor(Color.Color_555555)
                .padding(.leading, 5)
            }
            .padding([.leading, .trailing], 10)
        }
    }
}

// 机型小组件位置大小
extension ClockWidgetBundle {
    
    
    // 小组件在屏幕上的几个位置坐标，小组件大小和位置都可以通过以下数据换算得到、
    // 这里的大小只是内容区域的大小，不包含底部名称，
    func deviceInfos() -> [String: Array<Int>] {
        return [
            "320x568": [14, 165, 305, 30, 200, 370], // 4SE / 5 / 5S / SE。小组件只能放4个，中组件2个，大组件1个
            "375x667": [27, 200, 348, 30, 206, 382], // 8 / 7 / 6S / 6 / 4.7SE /
            "375x812": [23, 197, 352, 71, 261, 451], // 13Mini / 12Mini / 11Pro / XS / X /
            "390x844": [26, 206, 364, 77, 273, 469], // 14 / 13Pro / 13 / 12Pro / 12 /
            // TODO: - 待定 （小号试验完毕，可行）
            "393x852": [27, 206, 364, 90, 273, 469], // 15 / 15Pro / 14Pro /
            "414x736": [33, 224, 381, 38, 232, 426], // 8Plus / 7Plus / 6SPlus / 6Plus /
            "414x896": [27, 218, 387, 76, 286, 496], // 11PM / 11 / XS_MAX / XR /
            "428x926": [32, 226, 396, 82, 294, 506], // 14Plus / 13PM / 12PM
//            // TODO: - 待定 （小号试验完毕，可行）
            "430x932": [32, 226, 396, 94, 294, 506], // 15PM / 15Plus / 14PM /
            
            // 测试中性
//            "430x932": [34, 226, 396, 94, 294, 506], // 15PM / 15Plus / 14PM /
            // 测试大型
//            "430x932": [33, 226, 400, 94, 294, 506], // 15PM / 15Plus / 14PM /

        ]
    }
//    ______________large____width = 364.0__geight = 382.0
//    ______________large____width = 170.0__geight = 170.0
//    ______________large____width = 364.0__geight = 382.0
//    ______________medium____width = 364.0__geight = 170.0
//    ______________medium____width = 364.0__geight = 170.0
//    ______________medium____width = 170.0__geight = 170.0
//    ______________small____width = 170.0__geight = 170.0
//    ______________small____width = 170.0__geight = 170.0
//    ______________small____width = 170.0__geight = 170.0
//    ______________small____width = 158.0__geight = 158.0
//    ______________small____width = 158.0__geight = 158.0
    
    
    
    // 小组件尺寸为X3-X2的正方形
    // 中组件宽度为X3-X1，高度等同小组件 X3-X2
    // 大组件宽度为X3-X1, 高度为(Y2-Y1) + (X3-X2)
   
    // 小组件在不同屏幕的大小
    func getWidgetSize(_ widgetType: WidgetSizeType) -> CGSize {
        let wxh: String = "\(Int(UIScreen.main.bounds.size.width))x\(Int(UIScreen.main.bounds.size.height))"
        // TODO 外层做异常处理。告知用户 “您的机型暂不支持透明组件”
        if !deviceInfos().keys.contains(wxh) {
            return CGSize(width: -1, height: -1)
        }
        switch widgetType {
        case .small:
            let smallWidth = deviceInfos()[wxh]![2] - deviceInfos()[wxh]![1]
            return CGSize(width: smallWidth, height: smallWidth)
        case .medium:
            let mediumWidth = deviceInfos()[wxh]![2] - deviceInfos()[wxh]![0]
            let mediumHeight = deviceInfos()[wxh]![2] - deviceInfos()[wxh]![1]
            return CGSize(width: mediumWidth, height: mediumHeight)
        case .large:
            let largeWidth = deviceInfos()[wxh]![2] - deviceInfos()[wxh]![0]
            let largeHeight = deviceInfos()[wxh]![4] - deviceInfos()[wxh]![3] + deviceInfos()[wxh]![2] - deviceInfos()[wxh]![1]
            return CGSize(width: largeWidth, height: largeHeight)
        }
    }

    
    // 小组件。获取在不同位置的x,y坐标
    // 320x568的机型同屏只有4个位置能放小组件，其他尺寸比例的机型为6个
    func getSmallWidgetPos(_ widgetPos: SWidgetSizeEnum) -> CGPoint {
        let wxh: String = "\(Int(UIScreen.main.bounds.size.width))x\(Int(UIScreen.main.bounds.size.height))"
        // TODO 外层做异常处理。告知用户 “您的机型暂不支持透明组件”
        if !deviceInfos().keys.contains(wxh) {
            return CGPoint(x: -1, y: -1)
        }
        if (wxh == "320x568") {
            switch widgetPos {
            case .topLeft:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
            case .topRight:
                return CGPoint(x: deviceInfos()[wxh]![1], y: deviceInfos()[wxh]![3])
            case .middleLeft, .bottomLeft:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![4])
            case .middleRight, .bottomRight:
                return CGPoint(x: deviceInfos()[wxh]![1], y: deviceInfos()[wxh]![4])
            }
        } else {
            switch widgetPos {
            case .topLeft:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
            case .topRight:
                return CGPoint(x: deviceInfos()[wxh]![1], y: deviceInfos()[wxh]![3])
            case .middleLeft:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![4])
            case .middleRight:
                return CGPoint(x: deviceInfos()[wxh]![1], y: deviceInfos()[wxh]![4])
            case .bottomLeft:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![5])
            case .bottomRight:
                return CGPoint(x: deviceInfos()[wxh]![1], y: deviceInfos()[wxh]![5])
            }
        }
    }
    
    
    // 中组件。获取在不同位置的x,y坐标
    func getMiddleWidgetPos(_ widgetPos: MWidgetSizeEnum) -> CGPoint{
        let wxh: String = "\(Int(UIScreen.main.bounds.size.width))x\(Int(UIScreen.main.bounds.size.height))"
        // TODO 外层做异常处理。告知用户 “您的机型暂不支持透明组件”
        if !deviceInfos().keys.contains(wxh) {
            return CGPoint(x: -1, y: -1)
        }
        
        if (wxh == "320x568") {
            switch widgetPos {
            case .top:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
            case .middle, .bottom:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![4])
            }
        } else {
            switch widgetPos {
            case .top:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
            case .middle:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![4])
            case .bottom:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![5])
            }
        }
    }

    // 大组件。获取在不同位置的x,y坐标
    func getLargeWidgetPos(_ widgetPos: LWidgetSizeEnum) -> CGPoint {
        let wxh: String = "\(Int(UIScreen.main.bounds.size.width))x\(Int(UIScreen.main.bounds.size.height))"
        // TODO 外层做异常处理。告知用户 “您的机型暂不支持透明组件”
        if !deviceInfos().keys.contains(wxh) {
            return CGPoint(x: -1, y: -1)
        }
        if (wxh == "320x568") {
            return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
        } else {
            switch widgetPos {
            case .top:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![3])
            case .bottom:
                return CGPoint(x: deviceInfos()[wxh]![0], y: deviceInfos()[wxh]![4])
            }
        }
    }

        
    
}
 
