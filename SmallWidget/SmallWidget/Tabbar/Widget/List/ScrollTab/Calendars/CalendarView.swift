//
//  CalendarView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/12.
//

import SwiftUI

struct CalendarView: View {
        
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int
    
      let classSelf: [Any] = [
        CalendarMountainSmall.self, CalendarEmjioMeidum.self,
    ]

    var body: some View {
        GeometryReader { proxy in
            let leftWidth = (UIScreen.main.bounds.width - ViewLayout.S_W_20() * 2 - ViewLayout.S_W_15() * 2) / 3
            let rightWidth = leftWidth * 2 + ViewLayout.S_W_15()
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment:.center, spacing: 0) {
                    LazyVGrid(columns: [GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_15()), GridItem(.fixed(rightWidth), spacing: ViewLayout.S_W_15())], spacing: 0) {
                        ForEach(Array(classSelf.indices), id: \.self) { index in
                            if let itemWidgetView: any JRWidgetView.Type = classSelf[index] as? any JRWidgetView.Type {
                                let objectView = itemView(view: itemWidgetView, size: leftWidth, tabSelected: $tabSelected, widgetSelected: $widgetSelected)
                                    .frame(width: index % 2 == 0 ? leftWidth : rightWidth, height: leftWidth + ViewLayout.S_W_20())
                                    .padding(.top, ViewLayout.S_H_10())
                                AnyView(objectView)
                            }
                        }
                        .padding(.horizontal, 0)
                    }
                }
                .padding(.bottom, ViewLayout.SWidth(20))
            }
        }
    }
}
