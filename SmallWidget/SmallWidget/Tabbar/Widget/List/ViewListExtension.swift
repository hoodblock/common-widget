//
//  ViewListExtension.swift
//  SmallWidget
//
//  Created by Thomas on 2023/7/4.
//

import SwiftUI


// 生成不同的 widget  一个 Small 一个 Medium

extension View {
 
    @ViewBuilder
    func itemView<T: JRWidgetView>(view: T.Type, size: CGFloat, tabSelected: Binding<Tab>, widgetSelected: Binding<Int>) -> some View {
        let configure: JRWidgetConfigure = T(nil).configure!
        NavigationLink() {
            WidgetEditorView(tabSelected: tabSelected, widgetSelected: widgetSelected, configure: configure)
        } label: {
            VStack(spacing: 0) {
                if WidgetSizeType(rawValue: configure.nameConfig!.sizeType) == .medium {
                    Color.clear.edgesIgnoringSafeArea(.all).overlay {
                        GeometryReader { geometryProxy in
                            ZStack () {
                                T(nil)
                                    .frame(width: (WidgetSizeType(rawValue: configure.nameConfig!.sizeType)?.value)! * size, height: size)
                                    .cornerRadius(ViewLayout.SWidth(10))
                            }
                        }
                    }
                } else {
                    Color.clear.edgesIgnoringSafeArea(.all).overlay {
                        GeometryReader { geometryProxy in
                            ZStack () {
                                T(nil)
                                    .frame(width: size, height: size)
                                    .cornerRadius(ViewLayout.SWidth(10))
                            }
                        }
                    }
                }
                Text(configure.nameConfig?.orialName ?? "Widget")
                    .font(.S_Pro_10())
                    .foregroundColor(Color.Color_454545)
                    .padding(.top, ViewLayout.S_H_10())
                    .lineLimit(1)
            }
        }
    }
}

struct Previews_ViewListExtension_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, World!")
    }
}



