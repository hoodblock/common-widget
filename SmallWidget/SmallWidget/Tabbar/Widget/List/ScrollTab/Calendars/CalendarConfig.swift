//
//  CalendarConfig.swift
//  SmallWidget
//
//  Created by Thomas on 2023/11/7.
//

import SwiftUI
import WidgetKit


struct CalendarConfig: View {
    @Environment(\.widgetFamily) var widgetFamily;
    var configure: JRWidgetConfigure?
    let weekdays: Array<String> = ["S", "M", "T", "W", "T", "F", "S"]

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


extension CalendarConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "CalendarMountainSmall":
            CalendarMountainSmall(self.configure)
        case "CalendarEmjioMeidum":
            CalendarEmjioMeidum(self.configure)
        default:
            EmptyView()
        }
    }
}
