//
//  MediumTypeWidget.swift
//  ClockWidgetExtension
//
//  Created by Thomas on 2023/6/29.
//

import WidgetKit
import SwiftUI
import Intents

struct MediumTypeProvider: IntentTimelineProvider {
    
    // 添加组件弹框预览图
    func placeholder(in context: Context) -> MediumTypeEntry {
        if context.family == .systemSmall {
            if ((UserDefaults.standard.value(forKey: small_width) ?? 0) as? CGFloat ?? 0) < context.displaySize.width {
                UserDefaults.standard.setValue(context.displaySize.width, forKey: small_width)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.width, forKey: small_width)
            }
            if ((UserDefaults.standard.value(forKey: small_height) ?? 0) as? CGFloat ?? 0) < context.displaySize.height {
                UserDefaults.standard.setValue(context.displaySize.height, forKey: small_height)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.height, forKey: small_height)
            }
        } else if context.family == .systemMedium {
            if ((UserDefaults.standard.value(forKey: medium_width) ?? 0) as? CGFloat ?? 0) < context.displaySize.width {
                UserDefaults.standard.setValue(context.displaySize.width, forKey: medium_width)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.width, forKey: medium_width)
            }
            if ((UserDefaults.standard.value(forKey: medium_height) ?? 0) as? CGFloat ?? 0) < context.displaySize.height {
                UserDefaults.standard.setValue(context.displaySize.height, forKey: medium_height)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.height, forKey: medium_height)
            }
        } else if context.family == .systemLarge {
            if ((UserDefaults.standard.value(forKey: large_width) ?? 0) as? CGFloat ?? 0) < context.displaySize.width {
                UserDefaults.standard.setValue(context.displaySize.width, forKey: large_width)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.width, forKey: large_width)
            }
            if ((UserDefaults.standard.value(forKey: large_height) ?? 0) as? CGFloat ?? 0) < context.displaySize.height {
                UserDefaults.standard.setValue(context.displaySize.height, forKey: large_height)
                UserDefaults(suiteName: group_id)!.setValue(context.displaySize.height, forKey: large_height)
            }
        }
        return MediumTypeEntry(date: Date(), configuration: MediumWidgetConfigurationIntent())
    }
    
    func getSnapshot(for configuration: MediumWidgetConfigurationIntent, in context: Context, completion: @escaping (MediumTypeEntry) -> ()) {
        let entry = MediumTypeEntry(date: Date(), configuration: configuration)
        completion(entry)
    }
    
    // 时间线数组
    func getTimeline(for configuration: MediumWidgetConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MediumTypeEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = MediumTypeEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        // policy 时机
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    static var widgetFamily: WidgetFamily {
        return WidgetFamily.systemSmall
    }
}

// TimelineEntry 基础元素
struct MediumTypeEntry: TimelineEntry {
    let date: Date
    let configuration: MediumWidgetConfigurationIntent
}



// 外观
struct MediumTypeWidgetEntryView : View {
    
    @Environment(\.widgetFamily) private var widgetFamily     //这里是Widget的类型判断
    @Environment(\.colorScheme) var colorScheme
    var entry: MediumTypeProvider.Entry
    @State private var widgetConfig: JRWidgetConfigure = JRWidgetConfigure()
    @State private var transparentTypeImage: UIImage = UIImage()
    @State private var uploadLightImageString: String?
    @State private var uploadDarkImageString: String?

    
    // 裁剪
    func cropImage(image: UIImage, rect: CGRect) -> CGImage? {
        guard let cgImage = image.cgImage else {
            return nil
        }
        if  image.size.width < 1000 {
            guard let croppedCGImage = cgImage.cropping(to: CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width, height: rect.size.height)) else {
                return nil
            }
            return croppedCGImage
        } else {
            guard let croppedCGImage = cgImage.cropping(to: CGRect(x: rect.origin.x * 3, y: rect.origin.y * 3, width: rect.size.width * 3, height: rect.size.height * 3)) else {
                return nil
            }
            return croppedCGImage
        }
    }
    
    var body: some View {
        // 用保存的数据生成界面
        GeometryReader(content: { geometry in
            switch WidgetType(rawValue: widgetConfig.nameConfig?.widgetType ?? -1) {
            case .todo:
                TodoConfig(widgetFamily: 0, configure: widgetConfig)
            case .anniversary:
                AnniversaryConfig(widgetFamily: 0, configure: widgetConfig)
            case .imageAndWall:
                PhotoConfig(widgetFamily: 0, configure: widgetConfig)
            case .clock:
                ClockListConfig(widgetFamily: 0, configure: widgetConfig)
            case .battery:
                BatteryConfig(widgetFamily: 0, configure: widgetConfig)
            case .mood:
                MoodConfig(widgetFamily: 0, configure: widgetConfig)
            case .calendar:
                CalendarConfig(widgetFamily: 0, configure: widgetConfig)
            case .XPanel:
                XPanelConfig(widgetFamily: 0, configure: widgetConfig)
            case .none:
                if !(entry.configuration.configure?.ui?.configui?.count ?? 0 > 0) {
                    ClockWidgetBundle.providerView(app_name)
                }
            case .some(.large):
                if !(entry.configuration.configure?.ui?.configui?.count ?? 0 > 0) {
                    ClockWidgetBundle.providerView(app_name)
                }
            }
        })
        .widgetBackground(Color.clear) // <-- Key addition
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: (UserDefaults.standard.value(forKey: medium_width) as? CGFloat), minHeight: (UserDefaults.standard.value(forKey: medium_height) as? CGFloat))
        .onAppear(perform: {
            // 设置背景为小组件截图的背景
            // 设置背景透明，并且设置背景为截图背景
            // MARK: - 可以重置配置的背景和颜色和背景截图， 重置背景
            let configJsonString = entry.configuration.configure?.ui?.configui
            let staticJRWidgetConfig = JRWidgetConfigureStatic.deserialize(from: configJsonString) ?? JRWidgetConfigureStatic()
            // 跟随app，不变形，设置右上，截取右上的的图的大小，以此为例
            if (entry.configuration.dynamicTransparentType?.dynamicTransparent != dynamic_follow_app) && (entry.configuration.dynamicTransparentType?.dynamicTransparent?.count ?? 0 > 0) {
                if staticJRWidgetConfig.backgroundColor?.count ?? 0 > 0 {
                    staticJRWidgetConfig.backgroundColor = staticJRWidgetConfig.backgroundColor!.replacingCharacters(in: ..<staticJRWidgetConfig.backgroundColor!.index(staticJRWidgetConfig.backgroundColor!.startIndex, offsetBy: 4), with: "0x00")
                }
                // 获取截图， 使用上传的图，如果没有上传的图，就不换算
                // 获取手机当前模式
                if colorScheme == .light {
                    if (UserDefaults(suiteName: group_id)!.value(forKey:"UploadImageLightString") as? String) != nil {
                        let uploadLightImage = UIImage(data: Data(base64Encoded: (UserDefaults(suiteName: group_id)!.value(forKey: "UploadImageLightString")) as! String) ?? Data())
                        transparentTypeImage = uploadLightImage!
                    }
                } else {
                    if (UserDefaults(suiteName: group_id)!.value(forKey:"UploadImageDarkString") as? String) != nil {
                        let uploadDarktImage = UIImage(data: Data(base64Encoded: (UserDefaults(suiteName: group_id)!.value(forKey: "UploadImageDarkString")) as! String) ?? Data())
                        transparentTypeImage = uploadDarktImage!
                    }
                }
                if entry.configuration.dynamicTransparentType?.dynamicTransparent == dynamic_top {
                    if let croppedCGImage = cropImage(image: transparentTypeImage, rect: CGRect(origin: ClockWidgetBundle().getMiddleWidgetPos(.top), size: ClockWidgetBundle().getWidgetSize(.medium))) {
                        transparentTypeImage = UIImage(cgImage: croppedCGImage)
                    }
                } else if entry.configuration.dynamicTransparentType?.dynamicTransparent == dynamic_medium {
                    if let croppedCGImage = cropImage(image: transparentTypeImage, rect: CGRect(origin: ClockWidgetBundle().getMiddleWidgetPos(.middle), size: ClockWidgetBundle().getWidgetSize(.medium))) {
                        transparentTypeImage = UIImage(cgImage: croppedCGImage)
                    }
                } else if entry.configuration.dynamicTransparentType?.dynamicTransparent == dynamic_bottom {
                    if let croppedCGImage = cropImage(image: transparentTypeImage, rect: CGRect(origin: ClockWidgetBundle().getMiddleWidgetPos(.bottom), size: ClockWidgetBundle().getWidgetSize(.medium))) {
                        transparentTypeImage = UIImage(cgImage: croppedCGImage)
                    }
                }
                if let imageData = transparentTypeImage.jpegData(compressionQuality: 0.8) {
                    staticJRWidgetConfig.backgroundImageData = imageData.base64EncodedString()
                }
                
            }
            widgetConfig = JRWidgetConfigureStatic.widgetConfig(JRWidgetConfigureStatic.deserialize(from: staticJRWidgetConfig.toJSONString()) ?? JRWidgetConfigureStatic(), isInLayout: 0)
        })
    }
}

struct MediumTypeWidget: Widget {
    
    let kind: String = "MediumTypeWidget"
    
    var body: some WidgetConfiguration {
        if #available(iOSApplicationExtension 15.0, *) {
            return IntentConfiguration(kind: kind, intent: MediumWidgetConfigurationIntent.self, provider: MediumTypeProvider()) { entry in
                MediumTypeWidgetEntryView(entry: entry)
            }
            .supportedFamilies([.systemMedium])
            .configurationDisplayName("Medium Widgets")
            .description("Select the components to add to the desktop.")
            .contentMarginsDisabled()
        } else {
            return IntentConfiguration(kind: kind, intent: MediumWidgetConfigurationIntent.self, provider: MediumTypeProvider()) { entry in
                MediumTypeWidgetEntryView(entry: entry)
            }
            .supportedFamilies([.systemMedium])
            .configurationDisplayName("Medium Widgets")
            .description("Select the components to add to the desktop.")
        }
    }
}

struct MediumTypeWidget_Previews: PreviewProvider {
    static var previews: some View {
        MediumTypeWidgetEntryView(entry: MediumTypeEntry(date: Date(), configuration: MediumWidgetConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
