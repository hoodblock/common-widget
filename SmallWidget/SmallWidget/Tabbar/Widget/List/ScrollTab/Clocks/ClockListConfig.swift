//
//  ClockListConfig.swift
//  SmallWidget
//
//  Created by Q801 on 2024/2/22.
//

import SwiftUI
import WidgetKit


struct ClockListConfig: View {
    
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

extension ClockListConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "ClockOrangeSmall":
            ClockOrangeSmall(self.configure)
        case "ClockBlackMedium":
            ClockBlackMedium(self.configure)
        case "ClockAnimationSmall":
            ClockAnimationSmall(self.configure)
        case "ClockAnimationMedium":
            ClockAnimationMedium(self.configure)
        default:
            EmptyView()
        }
    }
}
