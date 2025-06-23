//
//  Mood0.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//


import SwiftUI
import WidgetKit



struct MoodConfig: View {
    
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

extension MoodConfig {
    
    func itemView() -> any View {
        switch self.configure?.nameConfig?.viewName {
        case "MoodColorfulMantouSmall_0":
            MoodColorfulMantouSmall_0(self.configure)
        case "MoodColorfulMantouSmall_1":
            MoodColorfulMantouSmall_1(self.configure)
        case "MoodColorfulMantouSmall_2":
            MoodColorfulMantouSmall_2(self.configure)
        case "MoodColorfulMantouSmall_3":
            MoodColorfulMantouSmall_3(self.configure)
        case "MoodColorfulMantouSmall_4":
            MoodColorfulMantouSmall_4(self.configure)
        default:
            EmptyView()
        }
    }
}

struct MoodConfig_Previews: PreviewProvider {
    static var previews: some View {
      EmptyView()
    }
}
