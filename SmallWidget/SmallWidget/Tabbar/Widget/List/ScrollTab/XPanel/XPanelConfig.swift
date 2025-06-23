//
//  XPanelConfig.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//

import SwiftUI
import WidgetKit
import Foundation


struct XPanelConfig: View {
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

extension XPanelConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "XPanelWhiteSmall":
            XPanelWhiteSmall(self.configure)
        case "XPanelWhiteMedium":
            XPanelWhiteMedium(self.configure)
        default:
            EmptyView()
        }
    }
}
