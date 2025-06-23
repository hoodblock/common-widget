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
                            // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                            .overlay {
//                                if configure.isVIP == 1 {
//                                    HStack (spacing: 0) {
//                                        Spacer()
//                                        VStack (spacing: 0) {
//                                            Image("widget_vip_icon")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                                .frame(width: ViewLayout.S_W_10() * 4, height: ViewLayout.S_W_10() * 4, alignment: .center)
//                                            Spacer()
//                                        }
//                                    }
//                                    .offset(x: ViewLayout.S_W_10(), y: -ViewLayout.S_W_10())
//                                }
//                            }
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
                            // MARK: - 去掉，因为已经强制不付费不允许进入app了
//                            .overlay {
//                                if configure.isVIP == 1 {
//                                    HStack (spacing: 0) {
//                                        Spacer()
//                                        VStack (spacing: 0) {
//                                            Image("widget_vip_icon")
//                                                .resizable()
//                                                .aspectRatio(contentMode: .fill)
//                                                .frame(width: ViewLayout.S_W_10() * 4, height: ViewLayout.S_W_10() * 4, alignment: .center)
//                                            Spacer()
//                                        }
//                                    }
//                                    .offset(x: ViewLayout.S_W_10(), y: -ViewLayout.S_W_10())
//                                }
//                            }
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



