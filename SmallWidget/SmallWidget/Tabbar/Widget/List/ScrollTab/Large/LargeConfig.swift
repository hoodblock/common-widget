//
//  LargeConfig.swift
//  SmallWidget
//
//  Created by nan on 2024/4/14.
//

import Foundation
import SwiftUI
import WidgetKit
import CoreGraphics


struct LargeConfig: View {
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

extension LargeConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "LargeStashView_0":
            LargeStashView_0(self.configure)
        default:
            EmptyView()
        }
    }
}
