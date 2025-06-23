//
//  PhotoConfig.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//

import SwiftUI
import WidgetKit
import CoreGraphics


struct PhotoConfig: View {
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

extension PhotoConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "PhotoLitttleTigerSmall":
            PhotoLitttleTigerSmall(self.configure)
        case "PhotoLitttleTigerMedium":
            PhotoLitttleTigerMedium(self.configure)
        case "PhotoWavePointBoxSmall":
            PhotoWavePointBoxSmall(self.configure)
        case "PhotoWavePointBoxMedium":
            PhotoWavePointBoxMedium(self.configure)
        default:
            EmptyView()
        }
    }
}



// 编辑配置
extension PhotoConfig {
    
    public func imageEditItemView(configure: JRWidgetConfigure?, isShowEdit: Bool) -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "PhotoLitttleTigerSmall":
            PhotoLitttleTigerSmall_Fill_Image(config: configure!, isShowEdit: isShowEdit)
        case "PhotoLitttleTigerMedium":
            PhotoLitttleTigerMedium_Fill_Image(config: configure!, isShowEdit: isShowEdit)
        case "PhotoWavePointBoxSmall":
            PhotoWavePointBoxSmall_Fill_Image(config: configure!, isShowEdit: isShowEdit)
        case "PhotoWavePointBoxMedium":
            PhotoWavePointBoxMedium_Fill_Image(config: configure!, isShowEdit: isShowEdit)
        default:
            EmptyView()
        }
    }
}

