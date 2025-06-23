//
//  AnniversaryConfig.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//


import SwiftUI
import WidgetKit


// 小组件加载的
struct AnniversaryConfig: View {
    
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

// 获取数据的
extension AnniversaryConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "AnniversarySnowMountainSmall":
            AnniversarySnowMountainSmall(self.configure)
        case "AnniversarySnowMountainMedium":
            AnniversarySnowMountainMedium(self.configure)
        case "AnniversaryEventsSmall":
            AnniversaryEventsSmall(self.configure)
        case "AnniversaryEventsMedium":
            AnniversaryEventsMedium(self.configure)
        default:
            EmptyView()
        }
    }
}

struct AnniversaryConfig_Previews: PreviewProvider {
    static var previews: some View {
        AnniversarySnowMountainSmall()
        AnniversarySnowMountainMedium()
    }
}
