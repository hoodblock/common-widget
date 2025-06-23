//
//  BatteryConfig.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//

import SwiftUI
import WidgetKit


/**
 ============================================================【 Kaka 】============================================================
 */

struct BatteryNumber {
    
    static func battery(_ isfirst: Bool = false, _ number: Int = 0) -> Int {
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLvl = Int(UIDevice.current.batteryLevel * 100)
    #if DEBUG
        return 50
    #else
        return batteryLvl
    #endif
    }
}


struct BatteryConfig: View {
    
    @Environment(\.widgetFamily) var widgetFamily;
    var configure: JRWidgetConfigure?

    init(widgetFamily: WidgetFamily.RawValue, configure: JRWidgetConfigure? = nil) {
        self.configure = configure
    }
    var body: some View {
        GeometryReader { geo in
            if configure?.backgroundImageData?.count ?? 0 > 0 {
                Image(uiImage: UIImage(data: Data(base64Encoded: configure?.backgroundImageData ?? "") ?? Data()) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .overlay {
                        AnyView(itemView())
                    }
            } else {
                AnyView(itemView())
                    .frame(width: .infinity, height: .infinity)
            }
        }
    }
}

extension BatteryConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "BatteryStyleSmall_0":
            return BatteryStyleSmall_0(self.configure)
        case "BatteryStyleSmall_1":
            return BatteryStyleSmall_1(self.configure)
        case "BatteryStyleSmall_2":
            return BatteryStyleSmall_2(self.configure)
        case "BatteryStyleSmall_3":
            return BatteryStyleSmall_3(self.configure)
        case "BatteryDarkSmall":
            return BatteryDarkSmall(self.configure)
        default:
            return EmptyView()
        }
    }
}

struct BatteryConfig_Previews: PreviewProvider {
    static var previews: some View {
        BatteryConfig(widgetFamily: 0, configure: JRWidgetConfigure())
    }
}
