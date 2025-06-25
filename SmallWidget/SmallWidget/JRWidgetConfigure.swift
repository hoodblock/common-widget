//
//  JRWidgetConfigure.swift
//  SmallWidget
//
//  Created by Thomas on 2023/7/1.
//

import WidgetKit
import SwiftUI
import HandyJSON

struct DateItem: Identifiable {
    let id = UUID()
    let date: Date
}

struct CustomWidgetFamily: EnvironmentKey {
    public static var defaultValue: WidgetFamily = .systemSmall
}

// 这里不能写成 widgetFamliy 不然和系统获取的有冲突
extension EnvironmentValues {
    var currentWidgetFamily: WidgetFamily {
        get { self[CustomWidgetFamily.self] }
        set { self[CustomWidgetFamily.self] = newValue }
    }
}
extension View {
    func readSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

extension Color {
    func readSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}

extension View {
    
    func gradientForeColor(_ colorString: String, _ unitpoint: UnitPoint = .topLeading) -> some View {
        var colors: [Color] = []
        if colorString.contains("-") {
            let parts = colorString.split(separator: "-").map { String($0) }
            for itemColorString in parts {
                colors.append(Color.color(hexString: itemColorString))
            }
        } else {
            colors = [Color.color(hexString: colorString), Color.color(hexString: colorString)]
        }
        if unitpoint == .topLeading {
            return foregroundStyle(.linearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
        } else if unitpoint == .leading {
            return foregroundStyle(.linearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
        } else if unitpoint == .top {
            return foregroundStyle(.linearGradient(colors: colors, startPoint: .top, endPoint: .bottom))
        }
        return foregroundStyle(.linearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    func gradientBackColor(_ colorString: String, _ unitpoint: UnitPoint = .topLeading) -> some View {
        var colors: [Color] = []
        if colorString.contains("-") {
            let parts = colorString.split(separator: "-").map { String($0) }
            for itemColorString in parts {
                colors.append(Color.color(hexString: itemColorString))
            }
        } else {
            colors = [Color.color(hexString: colorString), Color.color(hexString: colorString)]
        }
        if unitpoint == .topLeading {
            return background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
        } else if unitpoint == .leading {
            return background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
        } else if unitpoint == .top {
            return background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
        }
        return background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}


struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    let geoSize = proxy.size
                    Color.clear
                        .onAppear {
                            size = geoSize
                        }.onChange(of: geoSize) { newValue in
                            size = geoSize
                        }
                }
            )
    }
}



class WidgetNames: ObservableObject {

    // 类型名  小组件创建
    @Published var typeName: String?
        
    // 视图名  视图创建
    @Published var viewName: String?
    
    // 起始名
    @Published var orialName: String
    // 组件类别 0-小型， 1-中型， 2-大型
    @Published var sizeType:Int = 0
    
    @Published var widgetType: Int = -1
    
    required init(typeName: String, viewName: String, sizeType: WidgetSizeType, orialName: String, widgetType: WidgetType) {
        self.typeName = typeName
        self.viewName = viewName
        self.sizeType = sizeType.rawValue
        self.orialName = orialName
        self.widgetType = widgetType.rawValue
    }
    
    required init() {
        self.typeName = ""
        self.viewName = ""
        self.sizeType = 0
        self.orialName = ""
        self.widgetType = -1
    }
    
}


class WidgetTextConfig: ObservableObject {
    
    // 文字内容
    @Published var text: String = String()
    
    // 文字日期
    @Published var textDate: String = String()

    @Published var textList: [String] = [
        "Good mood～",
        "Read for half an hour",
        "Good luck～",
        "Drink 8 cups of hot water",
        "Early to bed early to rise",
    ]
    
    @Published var textListSelected: [Bool] = [
        false,
        false,
        false,
        false,
        false,
    ]
    
    @Published var textListCount: Int = 5
    // 文字背景颜色
    @Published var backgroudColor: String?
    
    // 文字颜色
    @Published var textColor: String?
    
    // 文字字体
    @Published var textFont: Int = 0

    // 0: No Loop  1: Monthly 2: Quarterly 3: Year
    @Published var textLoop: Int = 0
    
    required init() {
        
    }
}


// 图片旋转移动更新数据，图片专用
class ImageRotateAndMagnify: ObservableObject {
    // 放大因子
    @Published  var scale: Double = 1.00
    // 偏移角度
    @Published  var rotationDouble: Double = 0.00

    // 旋转初始位置
    @Published  var rotationStartLocation_x: Double = 0.00
    @Published  var rotationStartLocation_y: Double = 0.00

    // x / y偏移量
    @Published  var offset_x: Double = 0.00
    @Published  var offset_y: Double = 0.00

    required init() {
        
    }
}


// 界面流动数据
class JRWidgetConfigure: ObservableObject {
    
    // 基础设置
    @Published var nameConfig: WidgetNames?
    
    // 背景色
    @Published var backgroundColor: String?
    
    // 前景色
    @Published var foregroundColor: String?
    
    @Published var itemConfig_0: WidgetTextConfig = WidgetTextConfig()
    
    @Published var itemConfig_1: WidgetTextConfig = WidgetTextConfig()
    
    @Published var itemConfig_2: WidgetTextConfig = WidgetTextConfig()

    @Published var itemConfig_3: WidgetTextConfig = WidgetTextConfig()

    // 背景图
    @Published var backgroundImageData: String?
    
    // 照片墙填充图,为了方便，直接设置最大填充数
    @Published var fillingImageStringArray: [String?] = ["", "", ""]
    @Published var fillingImageCount: Int = 0 // 需要填充图片时，填充图片的次数，次数为1，则填充一张图

    @Published var fillingImageClipType: Int = 0 // 方形。// 1 长方形

    // 是否已经保存，从图片上展示
    @Published var isLocal: Bool = false
    
    // 是否需要编辑文字颜色
    @Published var isNeedTextColorEdit: Int = 0
    
    // 是否需要输入修改文字
    @Published var isNeedTextChangeEdit: Int = 0
    
    // 是否展示背景编辑，修改背景图或者颜色, 默认都展示
    @Published var isNeedBackgroudColorEdit: Int = 1
    
    // 是否需要几次编辑（就是同一种类型的编辑出现几次，比如三个textColor编辑
    @Published var isNeedItemEditCount: Int = 1
    
    // 是否需要设置步数选项
    @Published var isNeedSetingStep: Int = 0
    
    // 是否 属于app内部数据布局 1 / 0 // 1: 内部布局
    @Published var isInLayout: Int = 1
    
    // 图片更新器，更新图片角度和位置
    @Published var imageRotateAndMagnify_0: ImageRotateAndMagnify = ImageRotateAndMagnify()
    
    @Published var imageRotateAndMagnify_1: ImageRotateAndMagnify = ImageRotateAndMagnify()

    @Published var imageRotateAndMagnify_2: ImageRotateAndMagnify = ImageRotateAndMagnify()

    // 是否展示VIP标识， 默认不展示，默认不是VIP
    @Published var isVIP: Int = 0
    
    func reset() {
        backgroundColor = Color.String_Color_000000
    }

}


class StaticWidgetNames: HandyJSON {

    
    // 类型名  小组件创建
    var typeName: String?
        
    // 视图名  视图创建
    var viewName: String?
    
    // 起始名
    var orialName: String
    // 组件类别 0， 1， 2
    var sizeType:Int = 0
    
    var widgetType: Int = 0
    
    required init(typeName: String, viewName: String, sizeType: WidgetSizeType, orialName: String, widgetType: WidgetType) {
        self.typeName = typeName
        self.viewName = viewName
        self.sizeType = sizeType.rawValue
        self.orialName = orialName
        self.widgetType = widgetType.rawValue
    }
    
    required init() {
        self.typeName = ""
        self.viewName = ""
        self.sizeType = 0
        self.orialName = ""
        self.widgetType = 0
    }
    
}



// 静态
class StaticWidgetTextConfig: HandyJSON {
    
    // 文字内容
    var text: String = String()
    
    // 文字日期·
    var textDate: String = String()

    var textList: [String] = [
        "Good mood～",
        "Read for half an hour",
        "Good luck～",
        "Drink 8 cups of hot water",
        "Early to bed early to rise",
    ]
    var textListSelected: [Bool] = [
        false,
        false,
        false,
        false,
        false,
    ]
    var textListCount: Int = 5

    // 文字背景颜色
    var backgroudColor: String?
    
    // 文字颜色
    var textColor: String?
    
    var textFont: Int = 0
    
    // 文字大小
    var textSize: Int = 13 // 字体大小
    
    // 0: 细体  1: 中 2: 粗体
    var textType: Int = 0
    
    var textLoop: Int = 0

    required init() {
        
    }
}


// 图片旋转移动更新数据，图片专用
class StaticImageRotateAndMagnify: HandyJSON {
    // 放大因子
    var scale: Double = 1.00
    // 偏移角度
    var rotationDouble: Double = 0.00

    // 旋转初始位置
    var rotationStartLocation_x: Double = 0.00
    var rotationStartLocation_y: Double = 0.00

    // x / y偏移量
    var offset_x: Double = 0.00
    var offset_y: Double = 0.00
    
    required init() {
        
    }
}


class StaticWidgetItemConfig: HandyJSON {
    
    var thomas: CGPoint = .zero

    required init() {
        
    }
}

// 保存到数据库的数据
class JRWidgetConfigureStatic: HandyJSON {
    
    // 基础设置
    var nameConfig: StaticWidgetNames?

    // 背景色
    var backgroundColor: String?
    
    // 前景色
    var foregroundColor: String?
    
    var itemConfig_0: StaticWidgetTextConfig = StaticWidgetTextConfig()
    
    var itemConfig_1: StaticWidgetTextConfig = StaticWidgetTextConfig()
    
    var itemConfig_2: StaticWidgetTextConfig = StaticWidgetTextConfig()

    var itemConfig_3: StaticWidgetTextConfig = StaticWidgetTextConfig()

    // 背景图
    var backgroundImageData: String?
    
    // 照片墙填充图
    var fillingImageStringArray: [String?] = ["", "", ""]
    var fillingImageCount: Int = 0 // 需要填充图片时，填充图片的次数，次数为1，则填充一张图

    var fillingImageClipType: Int = 0 // 方形。// 1 长方形

    // 是否需要编辑文字选项
    var isNeedTextColorEdit: Int = 0
    
    // 是否需要输入修改文字
    var isNeedTextChangeEdit: Int = 0
    
    // 是否展示背景编辑，修改背景图或者颜色, 默认都展示
    var isNeedBackgroudColorEdit: Int = 1
    
    // 是否需要几次编辑（就是同一种类型的编辑出现几次，比如三个textColor编辑
    var isNeedItemEditCount: Int = 1
    
    // 是否 属于app内部数据布局 1 / 0 // 1: 内部布局
    var isInLayout: Int = 1
    
    // 是否需要设置步数选项
    var isNeedSetingStep: Int = 0
    
    // 图片更新器，更新图片角度和位置
    var imageRotateAndMagnify_0: StaticImageRotateAndMagnify = StaticImageRotateAndMagnify()
  
    var imageRotateAndMagnify_1: StaticImageRotateAndMagnify = StaticImageRotateAndMagnify()

    var imageRotateAndMagnify_2: StaticImageRotateAndMagnify = StaticImageRotateAndMagnify()

    // 是否展示VIP标识， 默认不展示，默认不是VIP
    var isVIP: Int = 0
    
    required init() {
        
    }
 
    // 转化 使用HandyJSON 转化时，由于使用 Published 导致转化失败，所以要去除Published，
    
    static func staticJRWidgetConfig(_ config: JRWidgetConfigure, isInLayout: Int = 1) -> JRWidgetConfigureStatic {
        let staticJRWidgetConfig = JRWidgetConfigureStatic()
        
        staticJRWidgetConfig.nameConfig = StaticWidgetNames()
        staticJRWidgetConfig.nameConfig?.typeName = config.nameConfig!.typeName
        staticJRWidgetConfig.nameConfig?.viewName = config.nameConfig!.viewName
        staticJRWidgetConfig.nameConfig?.viewName = config.nameConfig!.viewName
        staticJRWidgetConfig.nameConfig?.orialName = config.nameConfig!.orialName
        staticJRWidgetConfig.nameConfig?.sizeType = config.nameConfig!.sizeType
        staticJRWidgetConfig.nameConfig?.widgetType = config.nameConfig!.widgetType

        staticJRWidgetConfig.backgroundColor = config.backgroundColor
        staticJRWidgetConfig.foregroundColor = config.foregroundColor
        
        staticJRWidgetConfig.itemConfig_0.text = config.itemConfig_0.text
        staticJRWidgetConfig.itemConfig_0.textList = config.itemConfig_0.textList
        staticJRWidgetConfig.itemConfig_0.textListSelected = config.itemConfig_0.textListSelected
        staticJRWidgetConfig.itemConfig_0.textListCount = config.itemConfig_0.textListCount
        staticJRWidgetConfig.itemConfig_0.backgroudColor = config.itemConfig_0.backgroudColor
        staticJRWidgetConfig.itemConfig_0.textColor = config.itemConfig_0.textColor
        staticJRWidgetConfig.itemConfig_0.textDate = config.itemConfig_0.textDate
        staticJRWidgetConfig.itemConfig_0.textLoop = config.itemConfig_0.textLoop
        staticJRWidgetConfig.itemConfig_0.textFont = config.itemConfig_0.textFont

        staticJRWidgetConfig.itemConfig_1.text = config.itemConfig_1.text
        staticJRWidgetConfig.itemConfig_1.textList = config.itemConfig_1.textList
        staticJRWidgetConfig.itemConfig_1.textListSelected = config.itemConfig_1.textListSelected
        staticJRWidgetConfig.itemConfig_1.textListCount = config.itemConfig_1.textListCount
        staticJRWidgetConfig.itemConfig_1.backgroudColor = config.itemConfig_1.backgroudColor
        staticJRWidgetConfig.itemConfig_1.textColor = config.itemConfig_1.textColor
        staticJRWidgetConfig.itemConfig_1.textDate = config.itemConfig_1.textDate
        staticJRWidgetConfig.itemConfig_1.textLoop = config.itemConfig_1.textLoop
        staticJRWidgetConfig.itemConfig_1.textFont = config.itemConfig_1.textFont

        staticJRWidgetConfig.itemConfig_3.text = config.itemConfig_3.text
        staticJRWidgetConfig.itemConfig_3.textList = config.itemConfig_3.textList
        staticJRWidgetConfig.itemConfig_3.textListSelected = config.itemConfig_3.textListSelected
        staticJRWidgetConfig.itemConfig_3.textListCount = config.itemConfig_3.textListCount
        staticJRWidgetConfig.itemConfig_3.backgroudColor = config.itemConfig_3.backgroudColor
        staticJRWidgetConfig.itemConfig_3.textColor = config.itemConfig_3.textColor
        staticJRWidgetConfig.itemConfig_3.textDate = config.itemConfig_3.textDate
        staticJRWidgetConfig.itemConfig_3.textLoop = config.itemConfig_3.textLoop
        staticJRWidgetConfig.itemConfig_3.textFont = config.itemConfig_3.textFont
        
        staticJRWidgetConfig.backgroundImageData = config.backgroundImageData
        staticJRWidgetConfig.fillingImageStringArray = config.fillingImageStringArray
        staticJRWidgetConfig.fillingImageCount = config.fillingImageCount
        staticJRWidgetConfig.fillingImageClipType = config.fillingImageClipType

        staticJRWidgetConfig.itemConfig_2.text = config.itemConfig_2.text
        staticJRWidgetConfig.itemConfig_2.textList = config.itemConfig_2.textList
        staticJRWidgetConfig.itemConfig_2.textListSelected = config.itemConfig_2.textListSelected
        staticJRWidgetConfig.itemConfig_2.textListCount = config.itemConfig_2.textListCount
        staticJRWidgetConfig.itemConfig_2.backgroudColor = config.itemConfig_2.backgroudColor
        staticJRWidgetConfig.itemConfig_2.textColor = config.itemConfig_2.textColor
        staticJRWidgetConfig.itemConfig_2.textDate = config.itemConfig_2.textDate
        staticJRWidgetConfig.itemConfig_2.textLoop = config.itemConfig_2.textLoop
        staticJRWidgetConfig.itemConfig_2.textFont = config.itemConfig_2.textFont

        staticJRWidgetConfig.isNeedTextColorEdit = config.isNeedTextColorEdit
        staticJRWidgetConfig.isNeedTextChangeEdit = config.isNeedTextChangeEdit
        staticJRWidgetConfig.isNeedBackgroudColorEdit = config.isNeedBackgroudColorEdit
        staticJRWidgetConfig.isNeedItemEditCount = config.isNeedItemEditCount
        
        staticJRWidgetConfig.isInLayout = isInLayout

        staticJRWidgetConfig.imageRotateAndMagnify_0.offset_x = config.imageRotateAndMagnify_0.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_0.offset_y = config.imageRotateAndMagnify_0.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationStartLocation_x = config.imageRotateAndMagnify_0.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationStartLocation_y = config.imageRotateAndMagnify_0.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationDouble = config.imageRotateAndMagnify_0.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_0.scale = config.imageRotateAndMagnify_0.scale
        
        staticJRWidgetConfig.imageRotateAndMagnify_1.offset_x = config.imageRotateAndMagnify_1.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_1.offset_y = config.imageRotateAndMagnify_1.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationStartLocation_x = config.imageRotateAndMagnify_1.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationStartLocation_y = config.imageRotateAndMagnify_1.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationDouble = config.imageRotateAndMagnify_1.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_1.scale = config.imageRotateAndMagnify_1.scale
        
        staticJRWidgetConfig.imageRotateAndMagnify_2.offset_x = config.imageRotateAndMagnify_2.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_2.offset_y = config.imageRotateAndMagnify_2.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationStartLocation_x = config.imageRotateAndMagnify_2.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationStartLocation_y = config.imageRotateAndMagnify_2.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationDouble = config.imageRotateAndMagnify_2.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_2.scale = config.imageRotateAndMagnify_2.scale
        
        staticJRWidgetConfig.isVIP = config.isVIP

        return staticJRWidgetConfig
    }
    
    
    static func widgetConfig(_ config: JRWidgetConfigureStatic, isInLayout: Int = 1) -> JRWidgetConfigure {
        let staticJRWidgetConfig = JRWidgetConfigure()
        staticJRWidgetConfig.nameConfig = WidgetNames()
        staticJRWidgetConfig.nameConfig?.typeName = config.nameConfig?.typeName ?? ""
        staticJRWidgetConfig.nameConfig?.viewName = config.nameConfig?.viewName ?? ""
        staticJRWidgetConfig.nameConfig?.orialName = config.nameConfig?.orialName ?? ""
        staticJRWidgetConfig.nameConfig?.sizeType = config.nameConfig?.sizeType ?? 0
        staticJRWidgetConfig.nameConfig?.widgetType = config.nameConfig?.widgetType ?? -1

        staticJRWidgetConfig.backgroundColor = config.backgroundColor
        staticJRWidgetConfig.foregroundColor = config.foregroundColor
        
        staticJRWidgetConfig.itemConfig_0.text = config.itemConfig_0.text
        staticJRWidgetConfig.itemConfig_0.textList = config.itemConfig_0.textList
        staticJRWidgetConfig.itemConfig_0.textListSelected = config.itemConfig_0.textListSelected
        staticJRWidgetConfig.itemConfig_0.textListCount = config.itemConfig_0.textListCount
        staticJRWidgetConfig.itemConfig_0.backgroudColor = config.itemConfig_0.backgroudColor
        staticJRWidgetConfig.itemConfig_0.textColor = config.itemConfig_0.textColor
        staticJRWidgetConfig.itemConfig_0.textDate = config.itemConfig_0.textDate
        staticJRWidgetConfig.itemConfig_0.textLoop = config.itemConfig_0.textLoop
        staticJRWidgetConfig.itemConfig_0.textFont = config.itemConfig_0.textFont

        staticJRWidgetConfig.itemConfig_1.text = config.itemConfig_1.text
        staticJRWidgetConfig.itemConfig_1.textList = config.itemConfig_1.textList
        staticJRWidgetConfig.itemConfig_1.textListSelected = config.itemConfig_1.textListSelected
        staticJRWidgetConfig.itemConfig_1.textListCount = config.itemConfig_1.textListCount
        staticJRWidgetConfig.itemConfig_1.backgroudColor = config.itemConfig_1.backgroudColor
        staticJRWidgetConfig.itemConfig_1.textColor = config.itemConfig_1.textColor
        staticJRWidgetConfig.itemConfig_1.textDate = config.itemConfig_1.textDate
        staticJRWidgetConfig.itemConfig_1.textLoop = config.itemConfig_1.textLoop
        staticJRWidgetConfig.itemConfig_1.textFont = config.itemConfig_1.textFont

        staticJRWidgetConfig.itemConfig_3.text = config.itemConfig_3.text
        staticJRWidgetConfig.itemConfig_3.textList = config.itemConfig_3.textList
        staticJRWidgetConfig.itemConfig_3.textListSelected = config.itemConfig_3.textListSelected
        staticJRWidgetConfig.itemConfig_3.textListCount = config.itemConfig_3.textListCount
        staticJRWidgetConfig.itemConfig_3.backgroudColor = config.itemConfig_3.backgroudColor
        staticJRWidgetConfig.itemConfig_3.textColor = config.itemConfig_3.textColor
        staticJRWidgetConfig.itemConfig_3.textDate = config.itemConfig_3.textDate
        staticJRWidgetConfig.itemConfig_3.textLoop = config.itemConfig_3.textLoop
        staticJRWidgetConfig.itemConfig_3.textFont = config.itemConfig_3.textFont

        staticJRWidgetConfig.backgroundImageData = config.backgroundImageData
        staticJRWidgetConfig.fillingImageStringArray = config.fillingImageStringArray
        staticJRWidgetConfig.fillingImageClipType = config.fillingImageClipType
        staticJRWidgetConfig.fillingImageCount = config.fillingImageCount

        staticJRWidgetConfig.itemConfig_2.text = config.itemConfig_2.text
        staticJRWidgetConfig.itemConfig_2.textList = config.itemConfig_2.textList
        staticJRWidgetConfig.itemConfig_2.textListSelected = config.itemConfig_2.textListSelected
        staticJRWidgetConfig.itemConfig_2.textListCount = config.itemConfig_2.textListCount
        staticJRWidgetConfig.itemConfig_2.backgroudColor = config.itemConfig_2.backgroudColor
        staticJRWidgetConfig.itemConfig_2.textColor = config.itemConfig_2.textColor
        staticJRWidgetConfig.itemConfig_2.textDate = config.itemConfig_2.textDate
        staticJRWidgetConfig.itemConfig_2.textLoop = config.itemConfig_2.textLoop
        staticJRWidgetConfig.itemConfig_2.textFont = config.itemConfig_2.textFont

        staticJRWidgetConfig.isNeedTextColorEdit = config.isNeedTextColorEdit
        staticJRWidgetConfig.isNeedTextChangeEdit = config.isNeedTextChangeEdit
        
        staticJRWidgetConfig.isNeedBackgroudColorEdit = config.isNeedBackgroudColorEdit
        staticJRWidgetConfig.isNeedItemEditCount = config.isNeedItemEditCount

        staticJRWidgetConfig.isInLayout = isInLayout

        staticJRWidgetConfig.imageRotateAndMagnify_0.offset_x = config.imageRotateAndMagnify_0.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_0.offset_y = config.imageRotateAndMagnify_0.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationStartLocation_x = config.imageRotateAndMagnify_0.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationStartLocation_y = config.imageRotateAndMagnify_0.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_0.rotationDouble = config.imageRotateAndMagnify_0.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_0.scale = config.imageRotateAndMagnify_0.scale
        
        staticJRWidgetConfig.imageRotateAndMagnify_1.offset_x = config.imageRotateAndMagnify_1.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_1.offset_y = config.imageRotateAndMagnify_1.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationStartLocation_x = config.imageRotateAndMagnify_1.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationStartLocation_y = config.imageRotateAndMagnify_1.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_1.rotationDouble = config.imageRotateAndMagnify_1.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_1.scale = config.imageRotateAndMagnify_1.scale
        
        staticJRWidgetConfig.imageRotateAndMagnify_2.offset_x = config.imageRotateAndMagnify_2.offset_x
        staticJRWidgetConfig.imageRotateAndMagnify_2.offset_y = config.imageRotateAndMagnify_2.offset_y
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationStartLocation_x = config.imageRotateAndMagnify_2.rotationStartLocation_x
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationStartLocation_y = config.imageRotateAndMagnify_2.rotationStartLocation_y
        staticJRWidgetConfig.imageRotateAndMagnify_2.rotationDouble = config.imageRotateAndMagnify_2.rotationDouble
        staticJRWidgetConfig.imageRotateAndMagnify_2.scale = config.imageRotateAndMagnify_2.scale
        
        staticJRWidgetConfig.isVIP = config.isVIP

        return staticJRWidgetConfig
    }
    
}


enum WidgetSizeType: Int {
    case small = 0
    case medium = 1
    case large = 2
    
    var value: CGFloat {
        switch self {
        case .small:
            return 101.5 / 101.5
        case .medium:
            return 215 / 101.5
        case .large:
            return 215 / 215
        }
    }
    
    var scaleWidth: CGFloat {
        switch self {
        case.small:
            return 101.5
        case .medium:
            return  215
        case .large:
            return  215
        }
    }
    var sizeType: Int16 {
        switch self {
        case .small:
            return 0
        case .medium:
            return 1
        case .large:
            return 2
        }
    }
}

enum WidgetType: Int {
    case clock = 4               // 闹钟
    case calendar = 7            // 日历
    case XPanel = 8              // x面板
}

// 获取基础配置

struct WidgetViewConfig {
    
    static func widgetViewConfig(_ type: WidgetType, _ sizeType: WidgetSizeType) -> JRWidgetConfigure {
        var widgetConfigure: JRWidgetConfigure = JRWidgetConfigure()
        switch type {
        case .clock:
            widgetConfigure = ClockWidgetViewConfig.widgetViewConfig(sizeType)
        case .calendar:
            widgetConfigure = CalendarWidgetViewConfig.widgetViewConfig(sizeType)
        case .XPanel:
            widgetConfigure = XPanelWidgetViewConfig.widgetViewConfig(sizeType)
        }
        return widgetConfigure
    }
}

// MARK: - wall
struct WallWidgetViewConfig {
    
    static func widgetViewConfig(_ sizeType: WidgetSizeType) -> JRWidgetConfigure {
        let widgetConfigure: JRWidgetConfigure = JRWidgetConfigure()
        switch sizeType {
        case .small:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .small, orialName: "", widgetType: .clock)
        case .medium:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .medium, orialName: "", widgetType: .clock)
        case .large:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .large, orialName: "", widgetType: .clock)
        }
        return widgetConfigure
    }
}
    
    
// MARK: - Clock


struct ClockListConfiguration {
    
    let minute: CGFloat             // = 9
    let hourOff: CGFloat            // = 7
    let secondOff: CGFloat          // = 10
    
    let hourColor: Color            // = .gray
    let minnuteColor: Color         // = .blue
    let secondColor: Color          // = .clear

    init(minute: CGFloat = 9, hourOff: CGFloat = 7, secondOff: CGFloat = 10, hourColor: Color = .gray, minnuteColor: Color = .blue, secondColor: Color = .clear) {
        self.minute = minute
        self.hourOff = hourOff
        self.secondOff = secondOff
        self.hourColor = hourColor
        self.minnuteColor = minnuteColor
        self.secondColor = secondColor
    }
}

struct ClockListConfigureSize {
    let hour: CGFloat
    let minute: CGFloat
    let second: CGFloat
    
    init(hour: CGFloat = 6, minute: CGFloat = 4, second: CGFloat = 2) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}

struct ClockListConfigureScale {
    let hour: Double
    let minute: Double
    let second: Double
    init(hour: Double = 0.2, minute: Double = 0.3, second: Double = 0.4) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}


struct ClockWidgetViewConfig {
    
    static func widgetViewConfig(_ sizeType: WidgetSizeType) -> JRWidgetConfigure {
        let widgetConfigure: JRWidgetConfigure = JRWidgetConfigure()
        switch sizeType {
        case .small:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .small, orialName: "", widgetType: .clock)
        case .medium:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .medium, orialName: "", widgetType: .clock)
        case .large:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .large, orialName: "", widgetType: .clock)
        }
        return widgetConfigure
    }
}


// MARK: - Calendar

struct CalendarWidgetViewConfig {
    
    static func widgetViewConfig(_ sizeType: WidgetSizeType) -> JRWidgetConfigure {
        let widgetConfigure: JRWidgetConfigure = JRWidgetConfigure()
        switch sizeType {
        case .small:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .small, orialName: "", widgetType: .calendar)
        case .medium:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .medium, orialName: "", widgetType: .calendar)
        case .large:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .large, orialName: "", widgetType: .calendar)
        }
        return widgetConfigure
    }
}


// MARK: - XPanel

struct XPanelWidgetViewConfig {
    
    static func widgetViewConfig(_ sizeType: WidgetSizeType) -> JRWidgetConfigure {
        let widgetConfigure: JRWidgetConfigure = JRWidgetConfigure()
        switch sizeType {
        case .small:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .small, orialName: "", widgetType: .XPanel)
        case .medium:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .medium, orialName: "", widgetType: .XPanel)
        case .large:
            widgetConfigure.nameConfig = WidgetNames(typeName: "", viewName: "", sizeType: .large, orialName: "", widgetType: .XPanel)
        }
        return widgetConfigure
    }
}
