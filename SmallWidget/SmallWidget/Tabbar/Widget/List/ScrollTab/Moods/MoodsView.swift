//
//  MoodsView.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/13.
//

import SwiftUI

struct MoodsView: View {
    
    @Binding var tabSelected: Tab
    @Binding var widgetSelected: Int

    let classColorfulSelf: [Any] = [MoodColorfulMantouSmall_0.self, MoodColorfulMantouSmall_1.self, MoodColorfulMantouSmall_2.self, MoodColorfulMantouSmall_3.self, MoodColorfulMantouSmall_4.self]
   
    var body: some View {
        GeometryReader { proxy in
            let leftWidth = (UIScreen.main.bounds.width - ViewLayout.S_W_20() * 2 - ViewLayout.S_W_15() * 2) / 3
            ScrollView(.vertical, showsIndicators: false) {
                VStack (alignment: .center, spacing: 0) {
                    LazyVGrid(columns: [GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_15()), GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_15()), GridItem(.fixed(leftWidth), spacing: ViewLayout.S_W_15())], spacing: 0) {
                        ForEach(Array(classColorfulSelf.indices), id: \.self) { index in
                            if let itemWidgetView: any JRWidgetView.Type = classColorfulSelf[index] as? any JRWidgetView.Type {
                                let objectView = itemView(view: itemWidgetView, size: leftWidth, tabSelected: $tabSelected, widgetSelected: $widgetSelected)
                                    .frame(width: leftWidth , height: leftWidth + ViewLayout.S_W_20())
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
